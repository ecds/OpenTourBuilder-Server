# file battleofatlanta/apps/tour/urls.py

from django.conf.urls.defaults import *

urlpatterns = patterns('battleofatlanta.apps.tour.views',
    url(r'^(?P<slug>[-\w]+)/$', 'tour_detail', name='tour-detail'),
    url(r'^(?P<slug>[-\w]+)/(?P<page>\d+)/$', 'tour_stop_detail', name='tour-stop-detail'),
)