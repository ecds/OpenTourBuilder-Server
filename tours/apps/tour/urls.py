# file tours/apps/tour/urls.py

#from django.conf.urls.defaults import *
from django.conf.urls import patterns, url, include
from rest_framework.urlpatterns import format_suffix_patterns
from tours.apps.tour.views import TourList, TourDetail, TourStopDetail, TourInfoDetail

urlpatterns = [
    url(r'^tourLists/$', TourList.as_view()),
    url(r'^tourDetails/(?P<slug>[-\w]+)$', TourDetail.as_view()),
    url(r'^tourStopDetails/(?P<id>\d+)$', TourStopDetail.as_view()),
    url(r'^tourInfoDetails/(?P<id>\d+)$', TourInfoDetail.as_view()),
]

urlpatterns = format_suffix_patterns(urlpatterns)