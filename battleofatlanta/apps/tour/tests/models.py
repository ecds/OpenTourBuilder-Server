# file battleofatlanta/apps/tour/tests/models.py
#
#   Copyright 2012
#
#   License


from django.conf import settings
from django.core import management
from django.template import RequestContext, Template
from django.test import TestCase as DjangoTestCase

import logging
import nose.tools as nt

from battleofatlanta.apps.tour.models import Tour, TourStop

logger = logging.getLogger(__name__)

class TourTestCase(DjangoTestCase):
    fixtures = ["tours.json", "tour_stops.json"]

    def setUp(self):
        # get the tour
        self.tour = Tour.objects.get(pk=1)

    def test_init(self):
        logger.info("Tours: %s" % Tour.objects.all().count())
        nt.assert_true(isinstance(self.tour, Tour))
        nt.assert_equal(self.tour.name, "Battle of Atlanta")
        nt.assert_equal(self.tour.description, "A tour of the Battle of Atlanta")

    def test_tour_stops(self):
        nt.assert_true(self.tour.tourstop_set.all().count > 0)


class TourStopTestCase(object):
    def setup(self):
        self.tour_stop = TourStop()
        self.tour_stop.name = "Atlanta"

