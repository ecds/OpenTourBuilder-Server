# file tours/apps/tour/urls.py

#from django.conf.urls.defaults import *
from django.conf.urls import patterns, url, include

#handler403 = curry(permission_denied, template_name='403.html')
urlpatterns = patterns('tours.apps.tour.views',
    url(r'^update_directionsmode/(?P<mode>[-\w]+)/$', 'update_directionsmode', name='mode'),
    url(r'^(?P<slug>[-\w]+)/$', 'tour_detail', name='detail'),
    url(r'^(?P<slug>[-\w]+)/map/$', 'tour_map', name='tour-map'),
    url(r'^(?P<slug>[-\w]+)/(?P<page>\d+)/$', 'tour_stop_detail', name='stop-detail'),
    url(r'^(?P<slug>[-\w]+)/(?P<info>[-\w]+)/$', 'tour_info_detail', name='info-detail'),
    url(r'^(?P<slug>[-\w]+)/media/(?P<id>\d+)/$', 'tour_stop_media_detail', name='stop-media-detail'),
    url(r'^(?P<slug>[-\w]+)/map/(?P<page>\d+)/$', 'tour_stop_map', name='stop-map'),
#    url(r'^update_directionsmode/(?P<mode>[-\w]+)/$', 'update_directionsmode', name='switch'),
)
