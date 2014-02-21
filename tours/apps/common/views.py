# file tours/apps/common/views.py

from django.shortcuts import render_to_response, get_object_or_404
from django.template import RequestContext
from tours.apps.tour.models import Tour

def site_index(request):
    tours = ''
    if request.user.is_authenticated() is True:
        tours = Tour.objects.all()
    else:
        tours = Tour.objects.filter(published=True)
    return render_to_response('common/site_index.html', {'tours': tours,}, context_instance=RequestContext(request))
