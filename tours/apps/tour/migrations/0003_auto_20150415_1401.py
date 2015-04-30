# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        #('django_image_tools', '__first__'),
        ('tour', '0002_auto_20150415_1341'),
    ]

    operations = [
        migrations.AddField(
            model_name='tourstop',
            name='images',
            field=models.ManyToManyField(to='django_image_tools.Image'),
            preserve_default=True,
        ),
        migrations.AlterField(
            model_name='tourstopmedia',
            name='image',
            field=models.ImageField(upload_to=b'stops/', verbose_name=b'image'),
            preserve_default=True,
        ),
        migrations.AlterField(
            model_name='tourstopmedia',
            name='tour_stop',
            field=models.ForeignKey(related_name='foo', to='tour.TourStop'),
            preserve_default=True,
        ),
    ]
