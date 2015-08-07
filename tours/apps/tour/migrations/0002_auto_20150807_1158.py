# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import autoslug.fields


class Migration(migrations.Migration):

    dependencies = [
        ('tour', '0001_initial'),
    ]

    operations = [
        migrations.AddField(
            model_name='tourinfo',
            name='icon',
            field=models.CharField(default=b'fa-info-circle', max_length=20, choices=[(b'fa-info-circle', b'Info'), (b'fa-certificate', b'Certificat'), (b'fa-circle-o-notch', b'Circle'), (b'fa-sticky-note', b'Sticky Note'), (b'fa-bookmark', b'Bookmark')]),
        ),
        migrations.AlterField(
            model_name='tour',
            name='slug',
            field=autoslug.fields.AutoSlugField(editable=False, populate_from=b'name', always_update=True, unique=True),
        ),
        migrations.AlterField(
            model_name='tourinfo',
            name='info_slug',
            field=autoslug.fields.AutoSlugField(editable=False, populate_from=b'name', always_update=True, unique=True),
        ),
        migrations.AlterField(
            model_name='tourstop',
            name='slug',
            field=autoslug.fields.AutoSlugField(always_update=True, populate_from=b'name', editable=False),
        ),
    ]
