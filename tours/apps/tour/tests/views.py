# file tours/apps/tour/tests/views.py
#
#   Copyright 2012
#
#   License

from django.conf import settings
from django.core import management
from django.template import RequestContext, Template
from django.test import Client, TestCase as DjangoTestCase
from django.core.urlresolvers import reverse

import logging
import nose.tools as nt

from tours.apps.tour.models import Tour, TourStop

#class TourViewsTestCase(DjangoTestCase):
#    fixtures = ["tours.json", "tour_stops.json", "tour_info.json"]#, "tour_stop_media.json"]
#
#    def setUp(self):
#        self.client = Client()
#        self.tour = Tour.objects.get(pk=1)
#
#    def test_tour_detail_view(self):
#        test_tour = reverse('tour:detail', kwargs={'slug': self.tour.slug})
#        response = self.client.get(test_tour)
#        nt.eq_(response.status_code, 200, msg="Tour Detail view should respond with 200 for %s %s" % (test_tour, response.status_code))
#
#    def test_tour_stop_detail_view(self):
#        for ts in self.tour.tourstop_set.all():
#            print(ts.get_absolute_url())
#            response = self.client.get(ts.get_absolute_url())
#            nt.eq_(response.status_code, 200, msg="Tour Stop Detail view should respond with 200 for %s %s" % (ts.get_absolute_url(), response.status_code))
#
#    def test_tour_info_detail_view(self):
#        for ts in self.tour.tourinfo_set.all():
#            print(ts.get_absolute_url())
#            response = self.client.get(ts.get_absolute_url())
#            nt.eq_(response.status_code, 200, msg="Tour Stop Detail view should respond with 200 for %s %s" % (ts.get_absolute_url(), response.status_code))
