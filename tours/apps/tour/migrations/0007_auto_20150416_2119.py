# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import autoslug.fields


class Migration(migrations.Migration):

    dependencies = [
        ('tour', '0006_auto_20150416_1016'),
    ]

    operations = [
        migrations.AddField(
            model_name='tourstop',
            name='slug',
            field=autoslug.fields.AutoSlugField(default='foo', editable=False),
            preserve_default=False,
        ),
        migrations.AlterField(
            model_name='tourstopmedia',
            name='tour_stop',
            field=models.ForeignKey(related_name='images', to='tour.TourStop'),
            preserve_default=True,
        ),
    ]
