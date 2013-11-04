# file battleofatlanta/apps/tour/urls.py

from django.conf.urls.defaults import *

urlpatterns = patterns('battleofatlanta.apps.tour.views',
#    url(r'^(?P<slug>[-\w]+)/set_version/(?P<version>\w+)/$', 'set_version', name='version'),
#    url(r'^(?P<slug>[-\w]+)/switch_version/(?P<stop>\d+)/$', 'switch_version', name='switch'),
    url(r'^(?P<slug>[-\w]+)/$', 'tour_detail', name='detail'),
    url(r'^(?P<slug>[-\w]+)/(?P<page>\d+)/$', 'tour_stop_detail', name='stop-detail'),
    url(r'^(?P<slug>[-\w]+)/media/(?P<id>\d+)/$', 'tour_stop_media_detail', name='stop-media-detail'),
)
