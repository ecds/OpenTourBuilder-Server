# -*- coding: utf-8 -*-
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):

        # Changing field 'TourStop.description'
        db.alter_column('tour_tourstop', 'description', self.gf('tinymce.models.HTMLField')())

    def backwards(self, orm):

        # Changing field 'TourStop.description'
        db.alter_column('tour_tourstop', 'description', self.gf('django.db.models.fields.TextField')())

    models = {
        'tour.tour': {
            'Meta': {'object_name': 'Tour'},
            'description': ('django.db.models.fields.TextField', [], {}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
            'slug': ('autoslug.fields.AutoSlugField', [], {'unique': 'True', 'max_length': '50', 'populate_from': "'name'", 'unique_with': '()'})
        },
        'tour.tourstop': {
            'Meta': {'ordering': "['position']", 'object_name': 'TourStop'},
            'description': ('tinymce.models.HTMLField', [], {'default': "''", 'blank': 'True'}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'lat': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'lng': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
            'position': ('django.db.models.fields.PositiveSmallIntegerField', [], {}),
            'tour': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['tour.Tour']"})
        }
    }

    complete_apps = ['tour']