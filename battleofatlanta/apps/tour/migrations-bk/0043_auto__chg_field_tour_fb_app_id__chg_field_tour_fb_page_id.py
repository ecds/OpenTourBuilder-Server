# -*- coding: utf-8 -*-
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):

        # Changing field 'Tour.fb_app_id'
        db.alter_column('tour_tour', 'fb_app_id', self.gf('django.db.models.fields.CharField')(default='', max_length=50))

        # Changing field 'Tour.fb_page_id'
        db.alter_column('tour_tour', 'fb_page_id', self.gf('django.db.models.fields.CharField')(default='', max_length=50))

    def backwards(self, orm):

        # Changing field 'Tour.fb_app_id'
        db.alter_column('tour_tour', 'fb_app_id', self.gf('django.db.models.fields.IntegerField')(null=True))

        # Changing field 'Tour.fb_page_id'
        db.alter_column('tour_tour', 'fb_page_id', self.gf('django.db.models.fields.IntegerField')(null=True))

    models = {
        'tour.tour': {
            'Meta': {'object_name': 'Tour'},
            'description': ('tinymce.models.HTMLField', [], {}),
            'fb_app_id': ('django.db.models.fields.CharField', [], {'max_length': '50', 'blank': 'True'}),
            'fb_page_id': ('django.db.models.fields.CharField', [], {'max_length': '50', 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
            'slug': ('autoslug.fields.AutoSlugField', [], {'unique': 'True', 'max_length': '50', 'populate_from': "'name'", 'unique_with': '()'}),
            'splashimage': ('django.db.models.fields.files.ImageField', [], {'default': "''", 'max_length': '100', 'blank': 'True'}),
            'twitter_acct': ('django.db.models.fields.CharField', [], {'max_length': '50', 'blank': 'True'})
        },
        'tour.tourstop': {
            'Meta': {'ordering': "['position']", 'object_name': 'TourStop'},
            'article_link': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '525', 'blank': 'True'}),
            'description': ('tinymce.models.HTMLField', [], {'default': "''", 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'lat': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'lng': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'metadescription': ('django.db.models.fields.TextField', [], {'default': "''", 'blank': 'True'}),
            'mp4': ('django.db.models.fields.files.FileField', [], {'default': "''", 'max_length': '100', 'blank': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
            'ogg': ('django.db.models.fields.files.FileField', [], {'default': "''", 'max_length': '100', 'blank': 'True'}),
            'park_lat': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'park_lng': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'position': ('django.db.models.fields.PositiveSmallIntegerField', [], {'default': '17'}),
            'poster': ('django.db.models.fields.files.ImageField', [], {'default': "''", 'max_length': '100', 'blank': 'True'}),
            'tour': ('django.db.models.fields.related.ForeignKey', [], {'default': "'1'", 'to': "orm['tour.Tour']"})
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