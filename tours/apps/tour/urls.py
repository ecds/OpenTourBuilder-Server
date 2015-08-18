# file tours/apps/tour/urls.py

from django.conf.urls import url
from rest_framework.urlpatterns import format_suffix_patterns
from tours.apps.tour.views import TourList, TourDetail, TourStopDetail, TourInfoDetail, ImageDetail, tour_geojson

urlpatterns = [
    url(r'^tourLists/$', TourList.as_view()),
    url(r'^tourDetails/(?P<id>\d+)$', TourDetail.as_view()),
    url(r'^tourDetails/(?P<slug>[-\w]+)$', TourDetail.as_view(), name="tour_details_slug"),
    url(r'^tourStopDetails/(?P<id>\d+)$', TourStopDetail.as_view(), name="tour_stop_details"),
    url(r'^tourInfoDetails/(?P<id>\d+)$', TourInfoDetail.as_view(), name="tour_info_details"),
    url(r'^imageDetails/(?P<id>\d+)$', ImageDetail.as_view(), name="tour_image_details"),
    url(r'^tour_geojson/(?P<slug>.+)/$', tour_geojson, name='tour_geojson'),
]

urlpatterns = format_suffix_patterns(urlpatterns)