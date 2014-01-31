# file tours/apps/tour/views.py

from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext
from django.core.paginator import Paginator
from django.http import HttpResponseRedirect
from django.http import HttpResponse
from django.core.context_processors import csrf
from django.conf import settings
from tours.apps.tour.models import Tour, TourInfo, TourStop, TourStopMedia, DirectionsMode

def directions(request, slug):
    tour = tour = get_object_or_404(Tour, slug=slug)
    if  "directions" not in request.session:
        mode = str(tour.mode)
        request.session["directions"] = mode

def update_directionsmode(request, mode):
    if not request.is_ajax() or not request.method=='POST':
        return HttpResponseNotAllowed(['POST'])

    request.session['directions'] = mode
    return HttpResponse('ok')

def tour_detail(request, slug):
    tour = get_object_or_404(Tour, slug=slug)
    tour_info = tour.tourinfo_set.all()
    tour_stops = tour.tourstop_set.all()

    return render_to_response("tour/tour-detail.html", {
            'tour': tour,
            'tour_info': tour_info,
            'tour_stops': tour_stops,
        }, context_instance=RequestContext(request))

def tour_info_detail(request, slug, info):
    tour = get_object_or_404(Tour, slug=slug)
    tour_info = tour.tourinfo_set.filter(info_slug=info)


    return render_to_response("tour/tour_info-detail.html", {
            'info': info,
            'tour': tour,
            'tour_info': tour_info[0],
        }, context_instance=RequestContext(request))

def tour_stop_detail(request, slug, page):
    tour = get_object_or_404(Tour, slug=slug)

    directions(request, slug)

    paginator = Paginator(tour.tourstop_set.all(), 1)

    page = paginator.page(int(page))

    directions_pref = request.session["directions"]

    modes = DirectionsMode.objects.all()

    return render_to_response("tour/tour_stop-detail.html", {
            'tour': tour,
            'tour_stop': page[0],
            'images': page[0].tourstopmedia_set.all(),
            'page': page,
            'directions': directions_pref,
            'modes': modes,
    	    'sub': settings.SUB_URL,
        }, context_instance=RequestContext(request))

def tour_stop_media_detail(request, slug, id):
    tour_stop_media = get_object_or_404(TourStopMedia, pk=id)

    return render_to_response("tour/tour_stop_media-detail.html", {
            'tour_stop_media': tour_stop_media
        }, context_instance=RequestContext(request))
