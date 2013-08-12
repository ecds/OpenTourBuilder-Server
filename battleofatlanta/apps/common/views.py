# file battleofatlanta/apps/common/views.py

from django.shortcuts import render_to_response
from django.template import RequestContext

def site_index(request):
	request.session["tour_version"] = "full"
	return render_to_response('common/site_index.html', {}, context_instance=RequestContext(request))
