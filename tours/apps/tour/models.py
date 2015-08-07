# file tours/apps/tour/models.py

from django.core.files.uploadedfile import SimpleUploadedFile
from django.core.urlresolvers import reverse
from django.core.files import File
from django.db import models
from django.db.utils import ProgrammingError
from django.utils.translation import ugettext_lazy as _
from django.utils.html import strip_tags, escape
from django.template.defaultfilters import slugify
from django.conf import settings
from django.db.models import Max
from django import forms
from django.core.validators import ValidationError, RegexValidator, MaxLengthValidator, URLValidator
from django.contrib.sites.models import Site

# third party imports
from autoslug import AutoSlugField
from tinymce.models import HTMLField
from PIL import Image
import tempfile

from tours.apps.common.Resizers import Resize

from humanize import naturalsize

import re
import os


from cStringIO import StringIO

def validate_twitter(value):
    if '@' in value:
        raise ValidationError('Do not include the @ in your Twitter Account')

class DirectionsMode(models.Model):
    mode = models.CharField(max_length=50)

    def __unicode__(self):
        return "%s" % (self.mode)
    
def get_options():

    # This is sort of a hack to make the syncdb work.
    options = []
    try:
        modes = DirectionsMode.objects.all()
        for mode in modes:
            #print(mode.mode)
            options.insert(0, (mode.mode, mode.mode))
    except ProgrammingError:
        pass
    #print(options)
    return options


class Tour(models.Model):
    
    options = get_options
    
    name = models.CharField(max_length=50)
    published = models.BooleanField(default=False)
    geospatial = models.BooleanField(default=True)
    description = HTMLField()
    metadescription = models.TextField(blank=True, default='', validators=[MaxLengthValidator(350)])
    slug = AutoSlugField(populate_from='name', unique=True, always_update=True)
    modes = models.ManyToManyField(DirectionsMode, related_name='modes')
    default_mode = models.CharField(max_length = 50, choices = options(), blank=True, default='')
    fb_app_id = models.CharField(max_length=50, blank=True)
    fb_page_id = models.CharField(max_length=50, blank=True)
    twitter_acct = models.CharField(max_length=50, blank=True, validators=[validate_twitter])
    google_analytics = models.TextField(blank=True, default='')
    splashimage = models.ImageField(upload_to='tours/', blank=True, default='')

    class Meta:
        verbose_name = _('Tour')
        verbose_name_plural = _('Tours')    

    def __unicode__(self):
        return "%s" % (self.name)

    def get_absolute_url(self):
        return reverse('detail', kwargs={'slug': self.slug})

    @property
    def slug_class(self):
        return ".%s" % self.slug
    

    @property
    def phone_splash(self):
        '''
        Thumbnail for image on phone screens.
        '''
        if self.splashimage:
            image = Resize(self.splashimage)
            return Resize.splash_phone(image)
        else:
            return False

    @property
    def tablet_splash(self):
        '''
        Thumbnail for image on phone screens.
        '''
        if self.splashimage:
            image = Resize(self.splashimage)
            return Resize.splash_tablet(image)
        else:
            return False

    @property
    def desktop_splash(self):
        '''
        Thumbnail for image on phone screens.
        '''
        if self.splashimage:
            image = Resize(self.splashimage)
            return Resize.splash_desktop(image)
        else:
            return False

    @property
    def phone_default(self):
        '''
        Thumbnail for image on phone screens.
        '''
        if self.splashimage:
            image = Resize(self.splashimage)
            return Resize.gallery_phone(image)
        else:
            return False

    @property
    def tablet_default(self):
        '''
        Thumbnail for image on phone screens.
        '''
        if self.splashimage:
            image = Resize(self.splashimage)
            return Resize.gallery_tablet(image)
        else:
            return False

    @property
    def desktop_default(self):
        '''
        Thumbnail for image on phone screens.
        '''
        if self.splashimage:
            image = Resize(self.splashimage)
            return Resize.gallery_desktop(image)
        else:
            return False
    
    
def new_position(instance, tour_id):
    return TourStop.objects.filter(tour_id=tour_id).count()

def new_info_position(instance, tour_id):
    return TourStop.objects.filter(tour_id=tour_id).count()

def new_media_position(instance, tour_stop_id):
    return TourStopMedia.objects.filter(tour_stop_id=tour_stop_id).count()

def validate_https(value):
    if 'https' not in value:
        raise ValidationError('Make sure your embed link uses HTTPS.')

class TourInfo(models.Model):

    ICON_CHOICES = (
        ('fa-info-circle', 'Info'),
        ('fa-certificate', 'Certificate'),
        ('fa-circle-o-notch', 'Circle'),
        ('fa-sticky-note', 'Sticky Note'),
        ('fa-bookmark', 'Bookmark'),
    )

    tour = models.ForeignKey(Tour, related_name='info_ids')
    name = models.CharField(max_length=50)
    description = HTMLField(blank=True, default='')
    position = models.PositiveSmallIntegerField("Position", blank=True, null=True)
    info_slug = AutoSlugField(populate_from='name', unique=True, always_update=True)
    icon = models.CharField(max_length=20, choices=ICON_CHOICES, default='fa-info-circle')
    

    class Meta:
        verbose_name = _('Tour Info')
        verbose_name_plural = _('Tour Info')

        #set default ordering for the manager
        ordering = ['position']

    def __unicode__(self):
        return "%s - %s" % (self.name, self.tour.name)

    def get_absolute_url(self):
        return reverse('tour:info-detail', kwargs={"slug":  self.tour.slug, "info": self.info_slug})
    
    def save(self, force_insert=False, force_update=False):
        if self.position == None:# and self.tour:
            self.position = new_position(self, self.tour_id)
        super(TourInfo, self).save(force_insert, force_update)

class TourStop(models.Model):
    tour = models.ForeignKey(Tour, related_name='stop_ids')
    name = models.CharField(max_length=50)
    slug = AutoSlugField(populate_from='name', always_update=True)
    description = HTMLField(blank=True, default='')
    metadescription = models.TextField(blank=True, default='', validators=[MaxLengthValidator(350)])
    article_link = models.CharField(max_length=525, blank=True, default='')
    video_embed = models.CharField(max_length=50, blank=True, default='')
    video_poster = models.ImageField(upload_to='stops/', verbose_name='Video Poster', null=True, blank=True)
    # geo fields
    lat = models.FloatField(null=True, blank=True)
    lng = models.FloatField(null=True, blank=True)
    park_lat = models.FloatField(null=True, blank=True)
    park_lng = models.FloatField(null=True, blank=True)
    directions_intro = models.TextField(blank=True, default='', validators=[MaxLengthValidator(350)])
    direction_notes = HTMLField(blank=True, default='')

    # used in drag and drop reodering as well as tour stop order
    position = models.PositiveSmallIntegerField("Position", blank=True, null=True)

    class Meta:
        verbose_name = _('Tour Stop')
        verbose_name_plural = _('Tour Stops')

        #set default ordering for the manager
        ordering = ['position']

    def __unicode__(self):
        return "%s - %s" % (self.name, self.tour.name)

    @property
    def page(self):
        return self.position + 1

    @property
    def map_image(self):
        """
        This concatenates a link to make an api call to the Google static
        map images.
        """
        map_image = 'http://maps.googleapis.com/maps/api/staticmap?zoom=16&'
        map_image += 'size=150x150&maptype=roadmap&markers=color:red%7C'
        map_image += '%s,%s' % (self.lat, self.lng)
        map_image += '&sensor=false&key=AIzaSyBx6Zz6NMBoTBzIU0sbZQezxXgFMZdKZeI'
        return map_image

    @property
    def next_stop(self):
        stop_count = self.tour.stop_ids.all().count()
        if self.page >= stop_count:
            return ''
        else:
            stop = self.tour.stop_ids.get(position=self.page)
            # For nested links on the Ember side, return this:
            #previous_link = '/tour/%s/%s' % (self.tour_slug, stop.pk)
            next = '%s/%s' % (stop.slug, stop.pk)
            return stop.pk

    @property
    def previous_stop(self):
        if self.page == 1:
            return ''
        else:
            previous = self.position - 1
            stop = self.tour.stop_ids.get(position=previous)
            # For nested links on the Ember side, return this:
            #next_link = '/tour/%s/%s' % (self.tour_slug, stop.pk)
            previous = '%s/%s' % (stop.slug, stop.pk)
            return stop.pk

    @property
    def stop_link(self):
        return '/tour/%s/%s' % (self.tour_slug, self.pk)

    @property
    def direction_modes(self):
        tour_modes = self.tour.modes.all()
        modes = []
        # print(tour_modes)
        # # modes = 'foo'
        for mode in tour_modes:
            #print(mode)
            modes.append(str(mode))

        return modes
    
    @property
    def geospatial(self):
        return self.tour.geospatial
    
    @property
    def intro(self):
        return self.position == 0

    @property
    def phone_default(self):
        return self.tour.phone_default

    @property
    def tablet_default(self):
        return self.tour.tablet_default

    @property
    def desktop_default(self):
        return self.tour.desktop_default

    @property
    def phone_poster(self):
        if self.video_poster:
            image = Resize(self.video_poster)
            return Resize.gallery_phone(image)
        else:
            return self.phone_default

    @property
    def tablet_poster(self):
        if self.video_poster:
            image = Resize(self.video_poster)
            return Resize.gallery_tablet(image)
        else:
            return self.tablet_default

    @property
    def desktop_poster(self):
        if self.video_poster:
            image = Resize(self.video_poster)
            return Resize.gallery_desktop(image)
        else:
            return self.desktop_default
    

    @property
    def placeholder(self):
        return Site.objects.get_current().domain + \
                settings.MEDIA_URL + \
                'placeholder.png'
    

    def save(self, force_insert=False, force_update=False):
        if self.position == None:# and self.tour:
            self.position = new_position(self, self.tour_id)
        super(TourStop, self).save(force_insert, force_update)

class TourStopMedia(models.Model):
    tour_stop = models.ForeignKey(TourStop, related_name='images')
    title = models.CharField(max_length=50, blank=True, default='')
    caption = models.CharField(max_length=255, blank=True, default='')
    image = models.ImageField(upload_to='stops/', verbose_name='Image')
    source_link = models.CharField(max_length=525, blank=True, default='')
    metadata = HTMLField(blank=True, default='')
    
    # used in drag and drop reodering as well as tour stop order
    position = models.PositiveSmallIntegerField("Position", blank=True, null=True)

    class Meta:
        verbose_name = _('Tour Stop Media')
        verbose_name_plural = _('Tour Stop Media')
        
        #set default ordering for the manager
        ordering = ['position']

    def __unicode__(self):
        return self.title

    def get_absolute_url(self):
        return reverse('tour:stop-media-detail', kwargs={"slug":  self.tour_stop.tour.slug, "id": self.id})
        #return ""

    @property
    def label(self):
        return "%s-%s" % (slugify(self.title), self.id)

    @property
    def href(self):
        return "#%s-%s" % (slugify(self.title), self.id)

    @property
    def placeholder(self):
        return self.tour_stop.placeholder
    

    @property
    def size(self):
        '''
        Returs the file size of origianl image so user can be
        warned before loading original.
        '''
        size = os.path.getsize('%s/%s' % (settings.MEDIA_ROOT, self.image))
        return naturalsize(size)

    @property
    def original_image(self):
        '''
        Full url for original image.
        '''
        return Site.objects.get_current().domain + \
                settings.MEDIA_URL + \
                str(self.image)

    @property
    def image_preview(self):
        '''
        property to generate image prewiew. This is used on the
        list view when geospatial is turnedoff
        '''
        # preview = get_thumbnail('%s/%s' \
        #     % (settings.MEDIA_ROOT, self.image), \
        #     '80x80', crop='center', quality=70)
        # return Site.objects.get_current().domain + preview.url
        return 'foo'

    def resize_image(self, dimensions):
        """
        Send the image through the sorl thumbnail library
        and return the url to the file.
        """
        # new_image = get_thumbnail('%s/%s' \
        #     % (settings.MEDIA_ROOT, self.image), \
        #     'x%s' % dimensions, quality=70)
        # return Site.objects.get_current().domain + new_image.url
        return 'foo'

    @property
    def phone_thumb(self):
        '''
        Thumbnail for image on phone screens.
        '''
        image = Resize(self.image)
        return Resize.gallery_phone(image)


    @property
    def phone_full(self):
        '''
        Detail image for gallery on phone.
        '''
        image = Resize(self.image)
        return Resize.phone_full(image)

    @property
    def tablet_thumb(self):
        '''
        Thumbnail for image on tablet screens.
        '''
        image = Resize(self.image)
        return Resize.gallery_tablet(image)

    @property
    def tablet_full(self):
        '''
        Detail image for gallery on phone.
        '''
        image = Resize(self.image)
        return Resize.tablet_full(image)

    @property
    def desktop_thumb(self):
        '''
        Thumbnail for image on tablet screens.
        '''
        image = Resize(self.image)
        return Resize.gallery_desktop(image)

    @property
    def desktop_full(self):
        '''
        Thumbnail for image on tablet screens.
        '''
        image = Resize(self.image)
        return Resize.desktop_full(image)

    def save(self, *args, **kwargs):
        # override save method to resize image and generate thumbnail

        image_update = False
        # if pk is set, this is an update to an existing model;
        # check if the image is being changed
        if self.pk:
            orig = TourStopMedia.objects.get(pk=self.pk)
            if self.image != orig.image:
                image_update = True
                
        if self.position == None:
            self.position = new_media_position(self, self.tour_stop_id)

        super(TourStopMedia, self).save(*args, **kwargs)
