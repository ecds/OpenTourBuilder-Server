# -*- coding: utf-8 -*-
import datetime
from south.db import db
from south.v2 import SchemaMigration
from django.db import models


class Migration(SchemaMigration):

    def forwards(self, orm):
        # Deleting field 'Tour.mode'
        db.delete_column(u'tour_tour', 'mode_id')

        # Adding field 'Tour.default_mode'
        db.add_column(u'tour_tour', 'default_mode',
                      self.gf('django.db.models.fields.CharField')(default=1, max_length=50),
                      keep_default=False)

        # Adding M2M table for field modes on 'Tour'
        db.create_table(u'tour_tour_modes', (
            ('id', models.AutoField(verbose_name='ID', primary_key=True, auto_created=True)),
            ('tour', models.ForeignKey(orm[u'tour.tour'], null=False)),
            ('directionsmode', models.ForeignKey(orm[u'tour.directionsmode'], null=False))
        ))
        db.create_unique(u'tour_tour_modes', ['tour_id', 'directionsmode_id'])


    def backwards(self, orm):
        # Adding field 'Tour.mode'
        db.add_column(u'tour_tour', 'mode',
                      self.gf('django.db.models.fields.related.ForeignKey')(default=1, to=orm['tour.DirectionsMode']),
                      keep_default=False)

        # Deleting field 'Tour.default_mode'
        db.delete_column(u'tour_tour', 'default_mode')

        # Removing M2M table for field modes on 'Tour'
        db.delete_table('tour_tour_modes')


    models = {
        u'tour.directionsmode': {
            'Meta': {'object_name': 'DirectionsMode'},
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'mode': ('django.db.models.fields.CharField', [], {'max_length': '50'})
        },
        u'tour.tour': {
            'Meta': {'object_name': 'Tour'},
            'default_mode': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
            'description': ('tinymce.models.HTMLField', [], {}),
            'fb_app_id': ('django.db.models.fields.CharField', [], {'max_length': '50', 'blank': 'True'}),
            'fb_page_id': ('django.db.models.fields.CharField', [], {'max_length': '50', 'blank': 'True'}),
            'google_analytics': ('django.db.models.fields.TextField', [], {'default': "''", 'blank': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'modes': ('django.db.models.fields.related.ManyToManyField', [], {'to': u"orm['tour.DirectionsMode']", 'symmetrical': 'False', 'blank': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
            'published': ('django.db.models.fields.BooleanField', [], {'default': 'False'}),
            'slug': ('autoslug.fields.AutoSlugField', [], {'unique': 'True', 'max_length': '50', 'populate_from': "'name'", 'unique_with': '()'}),
            'splashimage': ('django.db.models.fields.files.ImageField', [], {'default': "''", 'max_length': '100', 'blank': 'True'}),
            'twitter_acct': ('django.db.models.fields.CharField', [], {'max_length': '50', 'blank': 'True'})
        },
        u'tour.tourinfo': {
            'Meta': {'ordering': "['position']", 'object_name': 'TourInfo'},
            'description': ('tinymce.models.HTMLField', [], {'default': "''", 'blank': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'info_slug': ('autoslug.fields.AutoSlugField', [], {'unique': 'True', 'max_length': '50', 'populate_from': "'name'", 'unique_with': '()'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
            'position': ('django.db.models.fields.PositiveSmallIntegerField', [], {'null': 'True', 'blank': 'True'}),
            'tour': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['tour.Tour']"})
        },
        u'tour.tourstop': {
            'Meta': {'ordering': "['position']", 'object_name': 'TourStop'},
            'article_link': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '525', 'blank': 'True'}),
            'description': ('tinymce.models.HTMLField', [], {'default': "''", 'blank': 'True'}),
            'direction_notes': ('tinymce.models.HTMLField', [], {'default': "''", 'blank': 'True'}),
            'directions_intro': ('django.db.models.fields.TextField', [], {'default': "''", 'blank': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'lat': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'lng': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'metadescription': ('django.db.models.fields.TextField', [], {'default': "''", 'blank': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
            'park_lat': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'park_lng': ('django.db.models.fields.FloatField', [], {'null': 'True', 'blank': 'True'}),
            'position': ('django.db.models.fields.PositiveSmallIntegerField', [], {'null': 'True', 'blank': 'True'}),
            'tour': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['tour.Tour']"}),
            'video_embed': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '50', 'blank': 'True'})
        },
        u'tour.tourstopmedia': {
            'Meta': {'ordering': "['position']", 'object_name': 'TourStopMedia'},
            'caption': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '255', 'blank': 'True'}),
            u'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'image': ('django.db.models.fields.files.ImageField', [], {'max_length': '100'}),
            'metadata': ('tinymce.models.HTMLField', [], {'default': "''", 'blank': 'True'}),
            'position': ('django.db.models.fields.PositiveSmallIntegerField', [], {'null': 'True', 'blank': 'True'}),
            'source_link': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '525', 'blank': 'True'}),
            'title': ('django.db.models.fields.CharField', [], {'default': "''", 'max_length': '50', 'blank': 'True'}),
            'tour_stop': ('django.db.models.fields.related.ForeignKey', [], {'to': u"orm['tour.TourStop']"})
        }
    }

    complete_apps = ['tour']