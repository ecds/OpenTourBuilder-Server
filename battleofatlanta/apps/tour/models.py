from django.db import models
from django.core.urlresolvers import reverse
from django.utils.translation import ugettext_lazy as _
from django.template.defaultfilters import slugify

# Create your models here.
class Tour(models.Model):
    name = models.CharField(max_length=50)
    description = models.TextField()
    slug = models.SlugField(editable=False)

    class Meta:
        verbose_name = _('Tour')
        verbose_name_plural = _('Tours')

    def __unicode__(self):
        return "%s" % (self.name)

    def save(self, *args, **kwargs):
        if not self.id:
            self.slug = slugify(self.name)

        super(Tour, self).save(*args, **kwargs)

class TourStop(models.Model):
    tour = models.ForeignKey(Tour)
    name = models.CharField(max_length=50)

    position = models.PositiveSmallIntegerField("Position")

    class Meta:
        verbose_name = _('Tour Stop')
        verbose_name_plural = _('Tour Stops')

        ordering = ['position']

    def __unicode__(self):
        return "%s - %s" % (self.name, self.tour.name)

    def get_absolute_url(self):
        return reverse('tour:tour-stop-detail', kwargs={"slug":  self.tour.slug, "id": self.id})
