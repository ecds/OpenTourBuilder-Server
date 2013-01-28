# file battleofatlanta/apps/tour/views.py

from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext
from django.core.paginator import Paginator

from battleofatlanta.apps.tour.models import Tour, TourStop, TourStopMedia


def tour_detail(request, slug):
    tour = get_object_or_404(Tour, slug=slug)
    tour_stops = tour.tourstop_set.all()

    return render_to_response("tour/tour-detail.html", {
            'tour': tour,
            'tour_stops': tour_stops
        }, context_instance=RequestContext(request))

def tour_stop_detail(request, slug, page):
    tour = get_object_or_404(Tour, slug=slug)
    paginator = Paginator(tour.tourstop_set.all(), 1)

    page = paginator.page(int(page))

    return render_to_response("tour/tour_stop-detail.html", {
            'tour_stop': page[0],
            'media': page[0].tourstopmedia_set.all(),
            'page': page,
        }, context_instance=RequestContext(request))

def tour_stop_media_detail(request, slug, id):
    tour_stop_media = get_object_or_404(TourStopMedia, pk=id)

    return render_to_response("tour/tour_stop_media-detail.html", {
            'tour_stop_media': tour_stop_media
        }, context_instance=RequestContext(request))