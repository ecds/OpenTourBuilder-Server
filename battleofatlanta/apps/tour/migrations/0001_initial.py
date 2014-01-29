# -*- coding: utf-8 -*-
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Adding model 'Tour'
        db.create_table('tour_tour', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=50)),
            ('description', self.gf('tinymce.models.HTMLField')()),
            ('slug', self.gf('autoslug.fields.AutoSlugField')(unique=True, max_length=50, populate_from='name', unique_with=())),
            ('fb_app_id', self.gf('django.db.models.fields.CharField')(max_length=50, blank=True)),
            ('fb_page_id', self.gf('django.db.models.fields.CharField')(max_length=50, blank=True)),
            ('twitter_acct', self.gf('django.db.models.fields.CharField')(max_length=50, blank=True)),
            ('google_analytics', self.gf('django.db.models.fields.TextField')(default='', blank=True)),
            ('splashimage', self.gf('django.db.models.fields.files.ImageField')(default='', max_length=100, blank=True)),
        ))
        db.send_create_signal('tour', ['Tour'])

        # Adding model 'TourInfo'
        db.create_table('tour_tourinfo', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('tour', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['tour.Tour'])),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=50)),
            ('description', self.gf('tinymce.models.HTMLField')(default='', blank=True)),
            ('position', self.gf('django.db.models.fields.PositiveSmallIntegerField')(default=1)),
            ('info_slug', self.gf('autoslug.fields.AutoSlugField')(default='', unique_with=(), max_length=50, populate_from='name')),
        ))
        db.send_create_signal('tour', ['TourInfo'])

        # Adding model 'TourStop'
        db.create_table('tour_tourstop', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('tour', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['tour.Tour'])),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=50)),
            ('description', self.gf('tinymce.models.HTMLField')(default='', blank=True)),
            ('metadescription', self.gf('django.db.models.fields.TextField')(default='', blank=True)),
            ('article_link', self.gf('django.db.models.fields.CharField')(default='', max_length=525, blank=True)),
            ('video_embed', self.gf('django.db.models.fields.CharField')(default='', max_length=50, blank=True)),
            ('lat', self.gf('django.db.models.fields.FloatField')(null=True, blank=True)),
            ('lng', self.gf('django.db.models.fields.FloatField')(null=True, blank=True)),
            ('park_lat', self.gf('django.db.models.fields.FloatField')(null=True, blank=True)),
            ('park_lng', self.gf('django.db.models.fields.FloatField')(null=True, blank=True)),
            ('direction_notes', self.gf('tinymce.models.HTMLField')(default='', blank=True)),
            ('position', self.gf('django.db.models.fields.PositiveSmallIntegerField')(default=19)),
        ))
        db.send_create_signal('tour', ['TourStop'])

        # Adding model 'TourStopMedia'
        db.create_table('tour_tourstopmedia', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('tour_stop', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['tour.TourStop'])),
            ('title', self.gf('django.db.models.fields.CharField')(default='', max_length=50, blank=True)),
            ('caption', self.gf('django.db.models.fields.CharField')(default='', max_length=255, blank=True)),
            ('image', self.gf('django.db.models.fields.files.FileField')(default='', max_length=100, blank=True)),
            ('inline', self.gf('django.db.models.fields.files.ImageField')(default='', max_length=100, blank=True)),
            ('source_link', self.gf('django.db.models.fields.CharField')(default='', max_length=525, blank=True)),
            ('metadata', self.gf('tinymce.models.HTMLField')(default='', blank=True)),
        ))
        db.send_create_signal('tour', ['TourStopMedia'])


    def backwards(self, orm):
        # Deleting model 'Tour'
        db.delete_table('tour_tour')

        # Deleting model 'TourInfo'
        db.delete_table('tour_tourinfo')

        # Deleting model 'TourStop'
        db.delete_table('tour_tourstop')

        # Deleting model 'TourStopMedia'
        db.delete_table('tour_tourstopmedia')


    models = {
        'tour.tour': {
            'Meta': {'object_name': 'Tour'},
            'description': ('tinymce.models.HTMLField', [], {}),
            'fb_app_id': ('django.db.models.fields.CharField', [], {'max_length': '50', 'blank': 'True'}),
            'fb_page_id': ('django.db.models.fields.CharField', [], {'max_length': '50', 'blank': 'True'}),
            'google_analytics': ('django.db.models.fields.TextField', [], {'default': "''", 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
            'slug': ('autoslug.fields.AutoSlugField', [], {'unique': 'True', 'max_length': '50', 'populate_from': "'name'", 'unique_with': '()'}),
            'splashimage': ('django.db.models.fields.files.ImageField', [], {'default': "''", 'max_length': '100', 'blank': 'True'}),
            'twitter_acct': ('django.db.models.fields.CharField', [], {'max_length': '50', 'blank': 'True'})
        },
        'tour.tourinfo': {
            'Meta': {'ordering': "['position']", 'object_name': 'TourInfo'},
            'description': ('tinymce.models.HTMLField', [], {'default': "''", 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'info_slug': ('autoslug.fields.AutoSlugField', [], {'default': "''", 'unique_with': '()', 'max_length': '50', 'populate_from': "'name'"}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
            'position': ('django.db.models.fields.PositiveSmallIntegerField', [], {'default': '1'}),
            'tour': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['tour.Tour']"})
        },
        'tour.tourstop': {
            'Meta': {'ordering': "['position']", 'object_name': 'TourStop'},
            'article_link': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '525', 'blank': 'True'}),
            'description': ('tinymce.models.HTMLField', [], {'default': "''", 'blank': 'True'}),
            'direction_notes': ('tinymce.models.HTMLField', [], {'default': "''", 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'lat': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'lng': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'metadescription': ('django.db.models.fields.TextField', [], {'default': "''", 'blank': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
            'park_lat': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'park_lng': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'position': ('django.db.models.fields.PositiveSmallIntegerField', [], {'default': '19'}),
            'tour': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['tour.Tour']"}),
            'video_embed': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '50', 'blank': 'True'})
        },
        'tour.tourstopmedia': {
            'Meta': {'object_name': 'TourStopMedia'},
            'caption': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '255', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'image': ('django.db.models.fields.files.FileField', [], {'default': "''", 'max_length': '100', 'blank': 'True'}),
            'inline': ('django.db.models.fields.files.ImageField', [], {'default': "''", 'max_length': '100', 'blank': 'True'}),
            'metadata': ('tinymce.models.HTMLField', [], {'default': "''", 'blank': 'True'}),
            'source_link': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '525', 'blank': 'True'}),
            'title': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '50', 'blank': 'True'}),
            'tour_stop': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['tour.TourStop']"})
        }
    }

    complete_apps = ['tour']