# file tours/apps/tour/views.py

from django.shortcuts import render_to_response, render, get_object_or_404
from django.template import RequestContext
from django.core.paginator import Paginator
from django.core.serializers import serialize
from django.http import HttpResponse, HttpResponseForbidden, Http404, StreamingHttpResponse
from django.core.context_processors import csrf
from django.conf import settings
from tours.apps.tour.models import Tour, TourInfo, TourStop, TourStopMedia, DirectionsMode
from django.db.models import Q

from rest_framework.views import APIView
from rest_framework.generics import ListAPIView
from rest_framework.response import Response
from rest_framework import status
from rest_framework_word_filter import FullWordSearchFilter
from tours.apps.tour.serializers import ToursSerializer, TourStopSerializer, TourInfoSerializer, MediaSerializer

######################
# START API STUFF HERE
######################

class TourList(ListAPIView):
    """
    List all tours.
    """
    def get(self, request, format=None, *args, **kwargs):
        published = request.query_params.get('published', False)
        if published:
            tours = Tour.objects.filter(published=True)
        else:
            tours = Tour.objects.all()

        serializer = ToursSerializer(tours, many=True)
        return Response(serializer.data)

class TourDetail(APIView):
    """
    Retrieve a tour instance.
    """

    def get(self, request, format=None, *args, **kwargs):
        """
        We want to return a tour based on a slug or id.
        """
        try:
            if 'id' in kwargs:
                tour = Tour.objects.get(pk=kwargs["id"])
            elif 'slug' in kwargs:
                tour = Tour.objects.get(slug=kwargs["slug"])
            serializer = ToursSerializer(tour)
        except Tour.DoesNotExist:
            raise Http404
        return Response(serializer.data)

class TourStopDetail(APIView):
    """
    Retrieve a tour stop instance
    """

    def get(self, request, format=None, *args, **kwargs):
        try:
            if 'id' in kwargs:
                tour_stop = TourStop.objects.get(pk=kwargs["id"])
                serializer = TourStopSerializer(tour_stop)

            elif 'search' in kwargs:
                search_term = self.request.query_params.get('search', None)

                search_result = TourStop.objects.filter( \
                    Q(name__icontains=search_term) | \
                    Q(description__icontains=search_term))

                serializer = TourStopSerializer(search_result, many=True)

        except TourStop.DoesNotExist:
            raise Http404
        return Response(serializer.data)

class TourInfoDetail(APIView):
    """
    Retrieve a tour info instance
    """

    def get(self, request, id, format=None):
        try:
            tour_info = TourInfo.objects.get(pk=id)
            serializer = TourInfoSerializer(tour_info)
        except TourInfo.DoesNotExist:
            raise Http404
        return Response(serializer.data)

class ImageDetail(APIView):
    """
    Retrieve an image instance.
    """

    def get(self, request, id, format=None):
        try:
            image = TourStopMedia.objects.get(pk=id)
            serializer = MediaSerializer(image)
        except TourStopMedia.DoesNotExist:
            raise Http404
        return Response(serializer.data)

def tour_geojson(request, slug):
    """
    Represent a tour in GeoJSON.
    """
    tour = Tour.objects.get(slug=slug)

    stops = []

    for stop in tour.stop_ids.all():
        if stop.position != 0:
            stop_geojson = '{"type": "Feature",'
            stop_geojson += '"geometry":{"type": "Point", "coordinates":['
            stop_geojson += '%s,%s,0]},' % (stop.lng, stop.lat)
            stop_geojson += '"properties": {'
            stop_geojson += '"name": "%s",' % stop.name

            if stop.article_link:
               stop.description += '<p><a href="%s" target="_blank">Read Full Article</a></p>' % stop.article_link
            # Clean up a few things from the wysiwyg.
            safe_description = stop.description.replace("\n", "")
            safe_description = safe_description.replace("\r", "")
            safe_description = safe_description.replace("\"", "\\\"")
            stop_geojson += '"description": "%s",' % safe_description
            stop_geojson += '"gx_media_links": "www.youtube.com/embed/%s"' % stop.video_embed
            stop_geojson += '}}'

            stops.append(stop_geojson)

    geojson = '{"type": "FeatureCollection","features": ['
    geojson += ','.join(map(str, stops))
    geojson += ']}'

    return StreamingHttpResponse(geojson, content_type='application/json')
