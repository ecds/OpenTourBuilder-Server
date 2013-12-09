# file battleofatlanta/apps/tour/models.py

from django.core.files.uploadedfile import SimpleUploadedFile
from django.core.urlresolvers import reverse
from django.db import models
from django.utils.translation import ugettext_lazy as _
from django.template.defaultfilters import slugify
from django.conf import settings
from django.db.models import Max
from django import forms
from django.core.validators import ValidationError, RegexValidator, MaxLengthValidator, URLValidator

# third party imports
from autoslug import AutoSlugField
from tinymce.models import HTMLField
from PIL import Image

import re
import os
import magic

from cStringIO import StringIO

def validate_twitter(value):
    if '@' in value:
        raise ValidationError('Do not include the @ in your Twitter Account')

class Tour(models.Model):
    name = models.CharField(max_length=50)
    description = HTMLField()
    slug = AutoSlugField(populate_from='name', unique=True, always_update=True)
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

    def __unicode__(self):
        return "%s" % (self.name)

#    def save(self, force_update=False, force_insert=False):

#         if self.splashimage:
#            image = Image.open(self.splashimage)

#            width = 290
#            height = 190

#            image.thumbnail((width, height), Image.ANTIALIAS)
#            image.save(self.splashimage.path)

            # save the thumbnail to memory
#            temp_handle = StringIO()
#            image.save(temp_handle, image.format)
#            temp_handle.seek(0) #rewind the file

#            suf = SimpleUploadedFile(os.path.split(self.splashimage.name)[-1],
#                                 temp_handle.read(),
#                                 content_type='image/%s' % image.format)
#            self.splashimage.save(suf.name, suf, save=False)
#            super(Tour, self).save()

#         else:
#            print('it is NULLLLLLLLLLLL')

class TourInfo(models.Model):
    tour = models.ForeignKey(Tour)
    name = models.CharField(max_length=50)
    description = HTMLField(blank=True, default='')
    position = models.PositiveSmallIntegerField("Position", default=1)
    info_slug = AutoSlugField(populate_from='name', unique=True, always_update=True)

    class Meta:
        verbose_name = _('Tour Info')
        verbose_name_plural = _('Tour Info')

        #set default ordering for the manager
        ordering = ['position']

    def __unicode__(self):
        return "%s - %s" % (self.name, self.tour.name)

    def get_absolute_url(self):
        return reverse('tour:info-detail', kwargs={"slug":  self.tour.slug, "info": self.info_slug})

def new_position(instance, tour_id):
    #if hasattr(TourStop, 'tour_id'):
    return TourStop.objects.filter(tour_id=tour_id).count()
    #else:
    #    return TourStop.objects.count()

# callback for tour_stop image name
def tour_stop_image_filename(instance, filename):
    fname, ext = os.path.splitext(filename)
    return '/'.join(['tour_stops', instance.tour_stop.slug, "%s%s" % (slugify(fname), ext)])

# callback for the inline path
def tour_stop_inline_filename(instance, filename):
    fname, ext = os.path.splitext(filename)
    return '/'.join(['tour_stops', instance.tour_stop.slug,'inline', "%s%s" % (slugify(fname), ext)])

def tour_splash_image_filename(instance, filename):
    fname, ext = os.path.splitext(filename)
    return '/'.join(['tours', instance.tour_stop.slug, "%s%s" % (slugify(fname), ext)])

def validate_https(value):
    if 'https' not in value:
        raise ValidationError('Make sure your embed link uses HTTPS.')

class TourStop(models.Model):
    tour = models.ForeignKey(Tour)
    name = models.CharField(max_length=50)
    description = HTMLField(blank=True, default='')
    metadescription = models.TextField(blank=True, default='', validators=[MaxLengthValidator(350)])
    article_link = models.CharField(max_length=525, blank=True, default='')
    video_embed = models.CharField(max_length=50, blank=True, default='', validators=[URLValidator(), validate_https])
    # geo fields
    lat = models.FloatField(null=True, blank=True)
    lng = models.FloatField(null=True, blank=True)
    park_lat = models.FloatField(null=True, blank=True)
    park_lng = models.FloatField(null=True, blank=True)
    parking_block = models.TextField(blank=True, default='')

    direction_notes = HTMLField(blank=True, default='')

    # used in drag and drop reodering as well as tour stop order
    position = models.PositiveSmallIntegerField("Position")

    class Meta:
        verbose_name = _('Tour Stop')
        verbose_name_plural = _('Tour Stops')

        #set default ordering for the manager
        ordering = ['position']

    def __unicode__(self):
        return "%s - %s" % (self.name, self.tour.name)

    def get_absolute_url(self):
        return reverse('tour:stop-detail', kwargs={"slug":  self.tour.slug, "page": self.position + 1})

    @property
    def slug(self):
        return slugify(self.name)

    def save(self, force_insert=False, force_update=False):
        #self.position = new_position()
        if self.position == None:
            print('No position')
            #new_position = self.objects.filter(tour_id=self.tour_id).count()
            self.position = new_position(self, self.tour_id)
            print('New position = %s' % ( self.position ))
        else:
            print('position = %s' % (self.position))
        super(TourStop, self).save(force_insert, force_update)

#    class Meta:
#        model = TourStop
#        widgets = {
#            'description': TinyMCE(mce_attrs={'content_css': "dev.emorydisc.org/battleofatlanta/static/css/structure.css"}),
#        }

class TourStopMedia(models.Model):
    tour_stop = models.ForeignKey(TourStop)
    title = models.CharField(max_length=50, blank=True, default='')
    caption = models.CharField(max_length=255, blank=True, default='')
    image = models.FileField(upload_to=tour_stop_image_filename, blank=True, default='')
    inline = models.ImageField(upload_to=tour_stop_inline_filename, blank=True, default='')
    source_link = models.CharField(max_length=525, blank=True, default='')
    metadata = HTMLField(blank=True, default='')

    class Meta:
        verbose_name = _('Tour Stop Media')
        verbose_name_plural = _('Tour Stop Media')

    def __unicode__(self):
        return self.title

    def get_absolute_url(self):
        return reverse('tour:stop-media-detail', kwargs={"slug":  self.tour_stop.tour.slug, "id": self.id})

    def save(self, force_update=False, force_insert=False):
        orig = None
        if self.pk is not None:
            orig = TourStopMedia.objects.get(pk=self.pk)
        # finally we save the TSMedia object
        super(TourStopMedia, self).save(force_update, force_insert)

        type = magic.from_file(getattr(settings, "MEDIA_ROOT", None) + '/' + str(self.image))

        if re.search('image', type):
    
            if not self.inline or (orig and self.image != orig.image):
                #create thumbnail if it doesn't exist
                image = Image.open(self.image)
    
                # retrieve original size for computation of thumb size
                width, height = image.size
    
                #compute thumb size currently hardcoded to maintain aspect ratio with 125px width
                # TODO: refactor to class variable
                inline_w = 290
                inline_h = height * inline_w / width
    
                image.thumbnail((inline_w, inline_h), Image.ANTIALIAS)
    
                # save the thumbnail to memory
                temp_handle = StringIO()
                image.save(temp_handle, image.format)
                temp_handle.seek(0) #rewind the file
    
                # save the thumbnail field
                suf = SimpleUploadedFile(os.path.split(self.image.name)[-1],
                                         temp_handle.read(),
                                        content_type='image/%s' % image.format)
                self.inline.save(suf.name, suf, save=False)

        # finally we save the TSMedia object
        super(TourStopMedia, self).save(force_update, force_insert)

