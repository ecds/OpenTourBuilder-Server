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
        #fields = ('name', 'description')

class TourStopSerializer(serializers.ModelSerializer):
    images = MediaSerializer(many=True)
    class Meta:
        model = TourStop

class ToursSerializer(serializers.ModelSerializer):
    stops = TourStopSerializer(many=True)
    modes = ModeSerializer(many=True)
    class Meta:
        model = Tour
        #fields = ('name', 'description', 'stops')