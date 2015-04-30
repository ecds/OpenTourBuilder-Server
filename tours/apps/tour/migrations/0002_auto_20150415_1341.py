# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        #('django_image_tools', '__first__'),
        ('tour', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='tour',
            name='geospatial',
            field=models.BooleanField(default=True),
            preserve_default=True,
        ),
        migrations.AddField(
            model_name='tourstopmedia',
            name='picture',
            field=models.ForeignKey(default=1, to='django_image_tools.Image'),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='tour',
            name='default_mode',
            field=models.CharField(default=b'', max_length=50, blank=True, choices=[('TRANSIT', 'TRANSIT'), ('BICYCLING', 'BICYCLING'), ('WALKING', 'WALKING')]),
            preserve_default=True,
        ),
        migrations.AlterField(
            model_name='tour',
            name='modes',
            field=models.ManyToManyField(related_name='modes', to='tour.DirectionsMode'),
            preserve_default=True,
        ),
        migrations.AlterField(
            model_name='tourinfo',
            name='tour',
            field=models.ForeignKey(related_name='info_ids', to='tour.Tour'),
            preserve_default=True,
        ),
        migrations.AlterField(
            model_name='tourstop',
            name='tour',
            field=models.ForeignKey(related_name='stop_ids', to='tour.Tour'),
            preserve_default=True,
        ),
        migrations.AlterField(
            model_name='tourstopmedia',
            name='tour_stop',
            field=models.ForeignKey(related_name='images', to='tour.TourStop'),
            preserve_default=True,
        ),
    ]
