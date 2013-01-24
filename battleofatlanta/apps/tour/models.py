# file battleofatlanta/apps/tour/models.py

from django.db import models
from django.core.urlresolvers import reverse
from django.utils.translation import ugettext_lazy as _

# third party imports
from autoslug import AutoSlugField
from tinymce.models import HTMLField

import re


class Tour(models.Model):
    name = models.CharField(max_length=50)
    description = HTMLField()
    slug = AutoSlugField(populate_from='name', unique=True)

    class Meta:
        verbose_name = _('Tour')
        verbose_name_plural = _('Tours')

    def __unicode__(self):
        return "%s" % (self.name)

    def get_absolute_url(self):
        return reverse('tour-detail', kwargs={'slug': self.slug})

class TourStop(models.Model):
    tour = models.ForeignKey(Tour)
    name = models.CharField(max_length=50)
    description = HTMLField(blank=True, default='')

    # geo fields
    lat = models.FloatField(null=True, blank=True)
    lng = models.FloatField(null=True, blank=True)

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
        return reverse('tour:tour-stop-detail', kwargs={"slug":  self.tour.slug, "page": self.position + 1})

# callback for tour_stop image name
def tour_stop_image_filename(instance, filename):
    return '/'.join(['tour_stops', re.sub(' ', '-',instance.tour_stop.name.lower()), re.sub(' ', '-', filename.lower())])

# callback for the thumbnail path
def tour_stop_thumb_filename(instance, filename):
    return '/'.join(['tour_stops', re.sub(' ', '-',instance.tour_stop.name.lower()),'thumbs', re.sub(' ', '-', filename.lower())])

class TourStopMedia(models.Model):
    tour_stop = models.ForeignKey(TourStop)
    title = models.CharField(max_length=50, blank=True, default='')
    caption = models.CharField(max_length=255, blank=True, default='')
    image = models.ImageField(upload_to=tour_stop_image_filename, blank=True, default='')
    thumbnail = models.ImageField(upload_to=tour_stop_thumb_filename, blank=True, default='')

    class Meta:
        verbose_name = _('Tour Stop Media')
        verbose_name_plural = _('Tour Stop Media')

    def __unicode__(self):
        return self.title

    def save(self, force_update=False, force_insert=False):
        from PIL import Image
        from cStringIO import StringIO
        from django.core.files.uploadedfile import SimpleUploadedFile
        import os

        image = Image.open(self.image)

        # retrieve original size for computation of thumb size
        width, height = image.size

        #compute thumb size currently hardcoded to maintain aspect ratio with 125px width
        thumb_w = 125
        thumb_h = height * thumb_w / width

        image.thumbnail((thumb_w, thumb_h), Image.ANTIALIAS)

        # save the thumbnail to memory
        temp_handle = StringIO()
        image.save(temp_handle, image.format)
        temp_handle.seek(0) #rewind the file

        # save the thumbnail field
        suf = SimpleUploadedFile(os.path.split(self.image.name)[-1],
                                 temp_handle.read(),
                                content_type='image/%s' % image.format)
        self.thumbnail.save(suf.name, suf, save=False)

        # finally we save the TSMedia object
        super(TourStopMedia, self).save(force_update, force_insert)
