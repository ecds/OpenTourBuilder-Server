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
            ('description', self.gf('django.db.models.fields.TextField')()),
        ))
        db.send_create_signal('tour', ['Tour'])

        # Adding model 'TourStop'
        db.create_table('tour_tourstop', (
            ('id', self.gf('django.db.models.fields.AutoField')(primary_key=True)),
            ('tour', self.gf('django.db.models.fields.related.ForeignKey')(to=orm['tour.Tour'])),
            ('name', self.gf('django.db.models.fields.CharField')(max_length=50)),
        ))
        db.send_create_signal('tour', ['TourStop'])


    def backwards(self, orm):
        # Deleting model 'Tour'
        db.delete_table('tour_tour')

        # Deleting model 'TourStop'
        db.delete_table('tour_tourstop')


    models = {
        'tour.tour': {
            'Meta': {'object_name': 'Tour'},
            'description': ('django.db.models.fields.TextField', [], {}),
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'})
        },
        'tour.tourstop': {
            'Meta': {'object_name': 'TourStop'},
            'id': ('django.db.models.fields.AutoField', [], {'primary_key': 'True'}),
            'name': ('django.db.models.fields.CharField', [], {'max_length': '50'}),
            'tour': ('django.db.models.fields.related.ForeignKey', [], {'to': "orm['tour.Tour']"})
        }
    }

    complete_apps = ['tour']