# file tours/apps/tour/views.py

from django.shortcuts import render_to_response, render, get_object_or_404
from django.template import RequestContext
from django.core.paginator import Paginator
from django.http import HttpResponse, HttpResponseForbidden, Http404
from django.core.context_processors import csrf
from django.conf import settings
from tours.apps.tour.models import Tour, TourInfo, TourStop, TourStopMedia, DirectionsMode

from rest_framework.views import APIView
from rest_framework.response import Response
from rest_framework import status
from tours.apps.tour.serializers import ToursSerializer, TourStopSerializer, TourInfoSerializer

'''
Decerator that will only display a tour if:
    Tour is published
    User is authenticated

Will not show the tour if:
    Tour is unpublished and user in not authenticated
'''
def check_published(view):
    def check(request, *args, **kwargs):
        tour = Tour.objects.get(slug=kwargs["slug"])
        user = request.user.is_authenticated()

        # Return 403 if no user and tour is unpublished
        if user is False and tour.published is False:
            return HttpResponseForbidden()

        # Show tour if user is authenticated or tour is published
        elif user is True or tour.published is True:
            return view(request, *args, **kwargs)

    return check

def directions(request, slug):
    tour = tour = get_object_or_404(Tour, slug=slug)
    if  "directions" not in request.session:
        mode = str(tour.default_mode)
        request.session["directions"] = mode

def update_directionsmode(request, mode):
    if not request.is_ajax() or not request.method=='POST':
        return HttpResponseNotAllowed(['POST'])

    request.session['directions'] = mode
    return HttpResponse('ok')

@check_published
def tour_detail(request, slug):
    tour = get_object_or_404(Tour, slug=slug)
    tour_info = tour.tourinfo_set.all()
    tour_stops = tour.tourstop_set.all()

    return render_to_response("tour/tour-detail.html", {
            'tour': tour,
            'tour_info': tour_info,
            'tour_stops': tour_stops,
        }, context_instance=RequestContext(request))

@check_published
def tour_map(request, slug):
    tour = get_object_or_404(Tour, slug=slug)
    tour_stops = tour.tourstop_set.all()

    return render(request, "tour/tour-map.html",
        {
            'tour': tour,
            'tour_stops': tour_stops,
        }
    )

@check_published
def tour_info_detail(request, slug, info):
    tour = get_object_or_404(Tour, slug=slug)
    tour_info = tour.tourinfo_set.filter(info_slug=info)


    return render_to_response("tour/tour_info-detail.html", {
            'info': info,
            'tour': tour,
            'tour_info': tour_info[0],
        }, context_instance=RequestContext(request))

@check_published
def tour_stop_detail(request, slug, page):
    tour = get_object_or_404(Tour, slug=slug)

    paginator = Paginator(tour.tourstop_set.all(), 1)

    page = paginator.page(int(page))

    return render( request, "tour/tour_stop-detail.html",
        {
            'tour': tour,
            'tour_stop': page[0],
            #'images': page[0].tourstopmedia_set.all(),
            'page': page,
            'sub': settings.SUB_URL,
        }
    )

@check_published
def tour_stop_map(request, slug, page):
    tour = get_object_or_404(Tour, slug=slug)
    tour_stops = tour.tourstop_set.all()
    paginator = Paginator(tour.tourstop_set.all(), 1)
    page = paginator.page(int(page))
    directions(request, slug)
    directions_pref = request.session["directions"]
    #modes = DirectionsMode.objects.all()
    
    return render(request, "tour/tour_stop-map.html",
        {
            'tour_stops': tour_stops,
            'tour': tour,
            'tour_stop': page[0],
            'page': page,
            'directions': directions_pref,
            'modes': tour.modes
        }
    )

@check_published
def tour_stop_media_detail(request, slug, id):
    tour_stop_media = get_object_or_404(TourStopMedia, pk=id)

    return render(request, "tour/tour_stop_media-detail.html",
        {
            'tour_stop_media': tour_stop_media
        }
    )

@check_published
def tour_stop_video_detail(request, slug, id):
    tour_stop = get_object_or_404(TourStop, pk=id)

    return render(request, "tour/tour_stop_video-detail.html",
        {
            'tour_stop': tour_stop
        }
    )


######################
# START API STUFF HERE
######################

class TourList(APIView):
    """
    List all tours.
    """
    def get(self, request, format=None):
        tours = Tour.objects.all()
        serializer = ToursSerializer(tours, many=True)
        return Response(serializer.data)

class TourDetail(APIView):
    """
    Retrieve a tour instance.
    """
    def get_object(self, slug):
        try:
            return Tour.objects.get(slug=slug)
        except Tour.DoesNotExist:
            raise Http404

    def get(self, request, slug, format=None):
        tour = self.get_object(slug=slug)
        serializer = ToursSerializer(tour)
        return Response(serializer.data)

class TourStopDetail(APIView):
    """
    Retrieve a tour stop instance
    """
    def get_object(self, id):
        try:
            return TourStop.objects.get(pk=id)
        except TourStop.DoesNotExist:
            raise Http404

    def get(self, request, id, format=None):
        tour_stop = self.get_object(id)
        serializer = TourStopSerializer(tour_stop)
        return Response(serializer.data)

class TourInfoDetail(APIView):
    """
    Retrieve a tour info instance
    """
    def get_object(self, id):
        try:
            return TourInfo.objects.get(pk=id)
        except TourInfo.DoesNotExist:
            raise Http404

    def get(self, request, id, format=None):
        tour_info = self.get_object(id)
        serializer = TourInfoSerializer(tour_info)
        return Response(serializer.data)

