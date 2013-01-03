from django.db import models
from django.core.urlresolvers import reverse
from django.utils.translation import ugettext_lazy as _

from autoslug import AutoSlugField

# Create your models here.
class Tour(models.Model):
    name = models.CharField(max_length=50)
    description = models.TextField()
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
    description = models.TextField(blank=True, default='')

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
