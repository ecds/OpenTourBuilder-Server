#tours/serializers.py

from tours.apps.tour.models import Tour, TourInfo, TourStop, TourStopMedia, DirectionsMode
from rest_framework import serializers

'''
For many to many relationships where you want to embed the image_ids
of the related items for Ember to handle, you need to set the `realated_name`
on the model class to be `opject_ids` and use `PrimaryKeyRelatedField`
For example:

`image_ids = serializers.PrimaryKeyRelatedField(many=True, read_only=True)`

'''


class ModeSerializer(serializers.ModelSerializer):
    class Meta:
        model = DirectionsMode
        #fields = ('name', 'description')

class MediaSerializer(serializers.ModelSerializer):
    class Meta:
        model = TourStopMedia
        fields = ('id', 'title', 'label', 'href', 'original_image', 'size', 'image_preview', \
                'position', 'phone_thumb', 'phone_full', 'tablet_thumb', \
                'tablet_full', 'desktop_thumb', 'desktop_full', 'caption', 'size', 'placeholder')

class ToursSerializer(serializers.ModelSerializer):
    stop_ids = serializers.PrimaryKeyRelatedField(many=True, read_only=True)
    info_ids = serializers.PrimaryKeyRelatedField(many=True, read_only=True)
    modes = ModeSerializer(many=True)
    class Meta:
        model = Tour
        fields = ('id', 'name', 'slug', 'description', 'stop_ids', \
                'info_ids', 'modes', 'published', 'geospatial', 'slug_class', \
                'phone_splash', 'tablet_splash', 'desktop_splash')

class TourStopSerializer(serializers.ModelSerializer):
    images = MediaSerializer(many=True)
    class Meta:
        model = TourStop
        fields = ('id', 'name', 'description', 'metadescription', \
                'article_link', 'position', 'map_image',\
                'video_embed', 'video_poster', 'geospatial', \
                'lat', 'lng', 'park_lat', 'park_lng', \
                'directions_intro', 'direction_notes', 'tour', \
                'direction_modes', 'stop_link', \
                'position', 'page', 'images', 'next_stop', \
                'previous_stop', 'intro', 'slug', 'phone_default', \
                'tablet_default', 'desktop_default', 'placeholder', \
                'phone_poster', 'tablet_poster', 'desktop_poster', 'tour_slug', \
                'published')

class TourInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = TourInfo
        fields = ('id', 'name', 'description', 'position', 'icon')
