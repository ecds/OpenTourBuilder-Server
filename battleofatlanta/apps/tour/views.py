# file battleofatlanta/apps/tour/views.py

from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext
from django.core.paginator import Paginator
from django.http import HttpResponseRedirect
from battleofatlanta.apps.tour.models import Tour, TourStop, TourStopMedia

#def def_tour(request):
    #print("session = %s" % request.session.get("tour_version", 'XXXXX'))
    #tour_version = request.session.get["tour_version"]
    #print(tour_version)
#    if  "tour_version" not in request.session:
#        request.session["tour_version"] = "full"

#def set_version(request, slug, version):
#    tour = get_object_or_404(Tour, slug=slug)
#    request.session["tour_version"] = version
#    return HttpResponseRedirect("/battleofatlanta/tour/battle-of-atlanta")

#def switch_version(request, slug, stop):
##    tour = get_object_or_404(Tour, slug=slug)
#    tour_version = request.session["tour_version"]
#    if tour_version == "full":
#       request.session["tour_version"] = "brief"
#    elif tour_version == "brief":
#       request.session["tour_version"] = "full"
#    return HttpResponseRedirect("/battleofatlanta/tour/battle-of-atlanta/" + stop)

def tour_detail(request, slug):
    tour = get_object_or_404(Tour, slug=slug)
    #def_tour(request)
    tour_stops = tour.tourstop_set.all()
    #tour_version = request.session["tour_version"]

    return render_to_response("tour/tour-detail.html", {
            'tour': tour,
            'tour_stops': tour_stops,
        #'tour_version': tour_version
        }, context_instance=RequestContext(request))

def tour_stop_detail(request, slug, page):
    tour = get_object_or_404(Tour, slug=slug)

    #def_tour(request)

    paginator = Paginator(tour.tourstop_set.all(), 1)

    page = paginator.page(int(page))

    #tour_version = request.session["tour_version"]
    #switch = ""
    #if tour_version == "full":
    #   switch = "Brief"
    #elif tour_version == "brief":
    #   switch = "Full"
    return render_to_response("tour/tour_stop-detail.html", {
            'tour_stop': page[0],
            'images': page[0].tourstopmedia_set.all(),
            'page': page,
        #'tour_version': tour_version,
         #   'switch': switch,
        }, context_instance=RequestContext(request))

def tour_stop_media_detail(request, slug, id):
    tour_stop_media = get_object_or_404(TourStopMedia, pk=id)

    return render_to_response("tour/tour_stop_media-detail.html", {
            'tour_stop_media': tour_stop_media
        }, context_instance=RequestContext(request))
