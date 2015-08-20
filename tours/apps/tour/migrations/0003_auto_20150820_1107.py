# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations


class Migration(migrations.Migration):

    dependencies = [
        ('tour', '0002_auto_20150807_1158'),
    ]

    operations = [
        migrations.AlterField(
            model_name='tourinfo',
            name='icon',
            field=models.CharField(default=b'fa-info-circle', max_length=20, choices=[(b'fa-info-circle', b'Info'), (b'fa-certificate', b'Certificate'), (b'fa-circle-o-notch', b'Circle'), (b'fa-sticky-note', b'Sticky Note'), (b'fa-bookmark', b'Bookmark')]),
        ),
    ]
