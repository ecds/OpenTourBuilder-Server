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
from django.conf import settings
import json
import shutil

import logging
import nose.tools as nt

from tours.apps.tour.models import Tour, TourInfo, TourStop, TourStopMedia, DirectionsMode

def getJsonString(response):
    """
    Running the response though this will enusre it is valid json.
    """
    json_string = ''

    for line in response:
        json_string += line

    # json.loads will throw an error if json is not valid.
    return json.loads(json_string)

class TourViewsTestCase(DjangoTestCase):
    fixtures = ["tours", "tour_stops", "tour_info", "tour_stop_media"]

    def setUp(self):
        self.client = Client()
        self.tour = Tour.objects.get(pk=1)
        self.media = TourStopMedia.objects.get(pk=1)

    def test_tour_detail_view(self):
        test_tour = reverse('tour:tour_details_slug', kwargs={'slug': self.tour.slug})
        response = self.client.get(test_tour)
        nt.eq_(response.status_code, 200, msg="Tour Detail view should respond with 200 for %s %s" % (test_tour, response.status_code))
        nt.assert_true(getJsonString(response))

        shutil.rmtree('%s/tours/phone' % settings.MEDIA_ROOT)
        shutil.rmtree('%s/tours/tablet' % settings.MEDIA_ROOT)

    def test_tour_stop_detail_view(self):
        for ts in self.tour.stop_ids.all():
            response = self.client.get(reverse('tour:tour_stop_details', kwargs={'id': ts.id}))
            nt.eq_(response.status_code, 200, msg="Tour Stop Detail view should respond with 200 for %s %s" % (ts.id, response.status_code))
            nt.assert_true(getJsonString(response))

        shutil.rmtree('%s/stops/phone' % settings.MEDIA_ROOT)
        shutil.rmtree('%s/stops/tablet' % settings.MEDIA_ROOT)
        shutil.rmtree('%s/stops/desktop' % settings.MEDIA_ROOT)
        shutil.rmtree('%s/stops/phone_full' % settings.MEDIA_ROOT)
        shutil.rmtree('%s/stops/tablet_full' % settings.MEDIA_ROOT)
        shutil.rmtree('%s/stops/desktop_full' % settings.MEDIA_ROOT)
        shutil.rmtree('%s/tours/phone' % settings.MEDIA_ROOT)
        shutil.rmtree('%s/tours/tablet' % settings.MEDIA_ROOT)

    def test_tour_info_detail_view(self):
        for ti in self.tour.info_ids.all():
            response = self.client.get(reverse('tour:tour_info_details', kwargs={'id': ti.id}))
            nt.eq_(response.status_code, 200, msg="Tour Info Detail view should respond with 200 for %s %s" % (ti.id, response.status_code))
            nt.assert_true(getJsonString(response))

    def test_tour_media_view(self):
        test_image = reverse('tour:tour_image_details', kwargs={'id': self.media.id})
        response = self.client.get(test_image)
        nt.eq_(response.status_code, 200, msg="Tour Image Detail view should respond with 200 for %s %s" % (test_image, response.status_code))
        nt.assert_true(getJsonString(response))
