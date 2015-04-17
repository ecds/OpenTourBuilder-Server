# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('tour', '0004_auto_20150415_1406'),
    ]

    operations = [
        migrations.RemoveField(
            model_name='tourstopmedia',
            name='picture',
        ),
    ]
