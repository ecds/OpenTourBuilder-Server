from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext

from battleofatlanta.apps.tour.models import Tour, TourStop


def tour_detail(request, slug):
    tour = get_object_or_404(Tour, slug=slug)
    tour_stops = tour.tourstop_set.all()

    return render_to_response("tour/tour-detail.html", {
            'tour': tour,
            'tour_stops': tour_stops
        }, context_instance=RequestContext(request))

def tour_stop_detail(request, slug, id):
    print "trying to get tour_stop"
    tour_stop = get_object_or_404(TourStop, pk=id)

    return render_to_response("tour/tour_stop-detail.html", {
            'tour_stop': tour_stop
        }, context_instance=RequestContext(request))