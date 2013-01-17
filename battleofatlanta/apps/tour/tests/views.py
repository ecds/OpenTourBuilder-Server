# file battleofatlanta/apps/tour/tests/views.py
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

from battleofatlanta.apps.tour.models import Tour, TourStop

class TourViewsTestCase(DjangoTestCase):
    fixtures = ["tours.json", "tour_stops.json"]

    def setUp(self):
        self.client = Client()
        self.tour = Tour.objects.get(pk=1)

    def test_tour_detail_view(self):
        response = self.client.get(reverse('tour:tour-detail', kwargs={'slug': self.tour.slug}))

        nt.eq_(response.status_code, 200, msg="Tour Detail view should respond with 200 for /tour/battle-of-atlanta/")

    def test_tour_stop_detail_view(self):
        for ts in self.tour.tourstop_set.all():
            response = self.client.get(ts.get_absolute_url())

            nt.eq_(response.status_code, 200, msg="Tour Stop Detail view should respond with 200 for %s" % ts.get_absolute_url())
