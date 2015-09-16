# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('tour', '0003_auto_20150820_1107'),
    ]

    operations = [
        migrations.AlterField(
            model_name='tour',
            name='default_mode',
            field=models.CharField(default=b'', max_length=50, blank=True),
        ),
    ]
