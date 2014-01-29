# file battleofatlanta/apps/tour/urls.py

from django.conf.urls.defaults import *

urlpatterns = patterns('battleofatlanta.apps.tour.views',
    url(r'^update_directionsmode/(?P<mode>[-\w]+)/$', 'update_directionsmode', name='mode'),
    url(r'^(?P<slug>[-\w]+)/$', 'tour_detail', name='detail'),
    url(r'^(?P<slug>[-\w]+)/(?P<page>\d+)/$', 'tour_stop_detail', name='stop-detail'),
    url(r'^(?P<slug>[-\w]+)/(?P<info>[-\w]+)/$', 'tour_info_detail', name='info-detail'),
    url(r'^(?P<slug>[-\w]+)/media/(?P<id>\d+)/$', 'tour_stop_media_detail', name='stop-media-detail'),
#    url(r'^update_directionsmode/(?P<mode>[-\w]+)/$', 'update_directionsmode', name='switch'),
)
