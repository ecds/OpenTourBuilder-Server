from django.shortcuts import render_to_response
from django.template import RequestContext

def tour_detail(request, slug):
    return render_to_response("tour/tour_detail.html", {}, context_instance=RequestContext(request))