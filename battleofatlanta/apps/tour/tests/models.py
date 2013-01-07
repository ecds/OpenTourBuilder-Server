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
    fixtures = ["tours.json"]

    def setUp(self):
        logger.info("Setting up Tour TestCase")
        management.call_command('loaddata', 'tours.json', verbosity='0')

        self.tour = Tour()
        self.tour.name = "Battle of Atlanta"
        self.tour.description = "A tour of the Battle of Atlanta"

    def test_init(self):
        nt.assert_true(isinstance(self.tour, Tour))
        nt.assert_equal(self.tour.name, "Battle of Atlanta")
        nt.assert_equal(self.tour.description, "A tour of the Battle of Atlanta")

class TourStopTestCase(object):
    def setup(self):
        self.tour_stop = TourStop()
        self.tour_stop.name = "Atlanta"

