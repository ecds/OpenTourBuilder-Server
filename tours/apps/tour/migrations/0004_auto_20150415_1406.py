# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('tour', '0003_auto_20150415_1401'),
    ]

    operations = [
        migrations.RenameField(
            model_name='tourstop',
            old_name='images',
            new_name='image_ids',
        ),
    ]
