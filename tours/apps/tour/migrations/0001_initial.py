# -*- coding: utf-8 -*-
from __future__ import unicode_literals

from django.db import models, migrations
import autoslug.fields
import tours.apps.tour.models
import tinymce.models
import django.core.validators


class Migration(migrations.Migration):

    dependencies = [
    ]

    operations = [
        migrations.CreateModel(
            name='DirectionsMode',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('mode', models.CharField(max_length=50)),
            ],
            options={
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='Tour',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=50)),
                ('published', models.BooleanField(default=False)),
                ('description', tinymce.models.HTMLField()),
                ('metadescription', models.TextField(default=b'', blank=True, validators=[django.core.validators.MaxLengthValidator(350)])),
                ('slug', autoslug.fields.AutoSlugField(unique=True, editable=False)),
                ('default_mode', models.CharField(default=b'', max_length=50, blank=True)),
                ('fb_app_id', models.CharField(max_length=50, blank=True)),
                ('fb_page_id', models.CharField(max_length=50, blank=True)),
                ('twitter_acct', models.CharField(blank=True, max_length=50, validators=[tours.apps.tour.models.validate_twitter])),
                ('google_analytics', models.TextField(default=b'', blank=True)),
                ('splashimage', models.ImageField(default=b'', upload_to=b'tours/', blank=True)),
                ('modes', models.ManyToManyField(to='tour.DirectionsMode')),
            ],
            options={
                'verbose_name': 'Tour',
                'verbose_name_plural': 'Tours',
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='TourInfo',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=50)),
                ('description', tinymce.models.HTMLField(default=b'', blank=True)),
                ('position', models.PositiveSmallIntegerField(null=True, verbose_name=b'Position', blank=True)),
                ('info_slug', autoslug.fields.AutoSlugField(unique=True, editable=False)),
                ('tour', models.ForeignKey(to='tour.Tour')),
            ],
            options={
                'ordering': ['position'],
                'verbose_name': 'Tour Info',
                'verbose_name_plural': 'Tour Info',
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='TourStop',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('name', models.CharField(max_length=50)),
                ('description', tinymce.models.HTMLField(default=b'', blank=True)),
                ('metadescription', models.TextField(default=b'', blank=True, validators=[django.core.validators.MaxLengthValidator(350)])),
                ('article_link', models.CharField(default=b'', max_length=525, blank=True)),
                ('video_embed', models.CharField(default=b'', max_length=50, blank=True)),
                ('video_poster', models.ImageField(upload_to=b'stops/', null=True, verbose_name=b'Video Poster', blank=True)),
                ('lat', models.FloatField(null=True, blank=True)),
                ('lng', models.FloatField(null=True, blank=True)),
                ('park_lat', models.FloatField(null=True, blank=True)),
                ('park_lng', models.FloatField(null=True, blank=True)),
                ('directions_intro', models.TextField(default=b'', blank=True, validators=[django.core.validators.MaxLengthValidator(350)])),
                ('direction_notes', tinymce.models.HTMLField(default=b'', blank=True)),
                ('position', models.PositiveSmallIntegerField(null=True, verbose_name=b'Position', blank=True)),
                ('tour', models.ForeignKey(to='tour.Tour')),
            ],
            options={
                'ordering': ['position'],
                'verbose_name': 'Tour Stop',
                'verbose_name_plural': 'Tour Stops',
            },
            bases=(models.Model,),
        ),
        migrations.CreateModel(
            name='TourStopMedia',
            fields=[
                ('id', models.AutoField(verbose_name='ID', serialize=False, auto_created=True, primary_key=True)),
                ('title', models.CharField(default=b'', max_length=50, blank=True)),
                ('caption', models.CharField(default=b'', max_length=255, blank=True)),
                ('image', models.ImageField(upload_to=b'stops/', verbose_name=b'Image')),
                ('source_link', models.CharField(default=b'', max_length=525, blank=True)),
                ('metadata', tinymce.models.HTMLField(default=b'', blank=True)),
                ('position', models.PositiveSmallIntegerField(null=True, verbose_name=b'Position', blank=True)),
                ('tour_stop', models.ForeignKey(to='tour.TourStop')),
            ],
            options={
                'ordering': ['position'],
                'verbose_name': 'Tour Stop Media',
                'verbose_name_plural': 'Tour Stop Media',
            },
            bases=(models.Model,),
        ),
    ]
