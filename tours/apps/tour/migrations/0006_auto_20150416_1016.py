# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('tour', '0005_remove_tourstopmedia_picture'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='tourstop',
            name='image_ids',
        ),
        migrations.AlterField(
            model_name='tourstopmedia',
            name='image',
            field=models.ImageField(upload_to=b'stops/', verbose_name=b'Image'),
            preserve_default=True,
        ),
        migrations.AlterField(
            model_name='tourstopmedia',
            name='tour_stop',
            field=models.ForeignKey(related_name='image_ids', to='tour.TourStop'),
            preserve_default=True,
        ),
    ]
