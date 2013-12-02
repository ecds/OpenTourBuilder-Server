# -*- coding: utf-8 -*-
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Deleting field 'TourInfo.body'
        db.delete_column('tour_tourinfo', 'body')

        # Adding field 'TourInfo.description'
        db.add_column('tour_tourinfo', 'description',
                      self.gf('tinymce.models.HTMLField')(default='', blank=True),
                      keep_default=False)


    def backwards(self, orm):
        # Adding field 'TourInfo.body'
        db.add_column('tour_tourinfo', 'body',
                      self.gf('tinymce.models.HTMLField')(default='', blank=True),
                      keep_default=False)

        # Deleting field 'TourInfo.description'
        db.delete_column('tour_tourinfo', 'description')


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