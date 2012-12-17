from django.conf.urls.defaults import *

urlpatterns = patterns('battleofatlanta.apps.tour.views',
    url(r'^(?P<slug>.+)/$', 'tour_detail', name='tour-detail')
)