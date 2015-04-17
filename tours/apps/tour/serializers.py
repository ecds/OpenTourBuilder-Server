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
        fields = ('title', 'original_image', 'size', 'image_preview', \
                'position', 'phone_thumb', 'phone_full', 'tablet_thumb', \
                'tablet_full')

class ToursSerializer(serializers.ModelSerializer):
    stop_ids = serializers.PrimaryKeyRelatedField(many=True, read_only=True)
    info_ids = serializers.PrimaryKeyRelatedField(many=True, read_only=True)
    modes = ModeSerializer(many=True)
    class Meta:
        model = Tour
        fields = ('id', 'name', 'slug', 'description', 'stop_ids', \
                'info_ids', 'modes', 'published', 'geospatial')

class TourStopSerializer(serializers.ModelSerializer):
    images = MediaSerializer(many=True)
    class Meta:
        model = TourStop
        fields = ('id', 'name', 'description', 'metadescription', \
                'article_link', 'position', 'map_image',\
                'video_embed', 'video_poster', 'geospatial', \
                'lat', 'lng', 'park_lat', 'park_lng', \
                'directions_intro', 'direction_notes', 'tour', \
                'direction_modes', 'tour_slug', 'stop_link', \
                'position', 'page', 'images', 'next_stop', \
                'previous_stop', 'intro')

class TourInfoSerializer(serializers.ModelSerializer):
    class Meta:
        model = TourInfo
        fields = ('id', 'name', 'description', 'position')
