# file tours/apps/tour/tests/models.py

from django.conf import settings
from django.core import management
from django.template import RequestContext, Template
from django.test import TestCase as DjangoTestCase
from django.conf import settings
import shutil
from PIL import Image


import logging
import nose.tools as nt

from tours.apps.tour.models import Tour, TourStop, TourInfo, TourStopMedia

logger = logging.getLogger(__name__)

class TourTestCase(DjangoTestCase):
    fixtures = ["tours", "tour_stops", "tour_info"]

    def setUp(self):
        # get the tour
        self.tour = Tour.objects.get(pk=1)

    def test_init(self):
        nt.assert_true(isinstance(self.tour, Tour))
        nt.eq_(self.tour.name, "Battle of Atlanta")
        nt.eq_(self.tour.description, "A tour of the Battle of Atlanta")
        nt.eq_(self.tour.slug, "battle-of-atlanta")
        nt.eq_(self.tour.slug_class, ".battle-of-atlanta")
        nt.eq_(self.tour.geospatial, True)
        nt.eq_(self.tour.default_mode, 'bicycling')
        nt.eq_(self.tour.google_analytics, 'some code')

        nt.eq_(self.tour.phone_splash, 'example.com/media/tours/phone/465-465-epic_wizard_riding_shark_surfing_raptor.png')
        phone_splash = Image.open('%s/tours/phone/%s' % (settings.MEDIA_ROOT, self.tour.phone_splash.split('/')[-1]))
        nt.eq_(phone_splash.size, (465, 361))

        nt.eq_(self.tour.tablet_splash, 'example.com/media/tours/tablet/650-650-epic_wizard_riding_shark_surfing_raptor.png')
        tablet_splash = Image.open('%s/tours/tablet/%s' % (settings.MEDIA_ROOT, self.tour.tablet_splash.split('/')[-1]))
        nt.eq_(tablet_splash.size, (650, 505))

        nt.eq_(self.tour.desktop_splash, 'example.com/media/%s' % self.tour.splashimage)
        desktop_splash = Image.open('%s/tours/%s' % (settings.MEDIA_ROOT, self.tour.desktop_splash.split('/')[-1]))
        nt.eq_(desktop_splash.size, (1600, 1244))

        shutil.rmtree('%s/tours/phone' % settings.MEDIA_ROOT)
        shutil.rmtree('%s/tours/tablet' % settings.MEDIA_ROOT)

    def test_tour_stops(self):
        nt.eq_(self.tour.stop_ids.all().count(), 3, msg="The tour fixture should have 3 tour stops.")

    def test_tour_infos(self):
        nt.eq_(self.tour.info_ids.all().count(), 2, msg="The tour fixture should have 3 tour infos.")



class TourStopTestCase(DjangoTestCase):
    fixtures = ["tours", "tour_stops", "initial_data", "tour_modes"]
    
    def test_init(self):
        tourstop = TourStop.objects.get(pk=1)
        nt.assert_true(isinstance(tourstop, TourStop))
        nt.eq_(tourstop.name, "Atlanta")
        nt.eq_(tourstop.page, 1)
        nt.eq_(tourstop.map_image, "http://maps.googleapis.com/maps/api/staticmap?zoom=16&size=150x150&maptype=roadmap&markers=color:red%7C33.0,-84.0&sensor=false&key=AIzaSyBx6Zz6NMBoTBzIU0sbZQezxXgFMZdKZeI")
        nt.eq_(tourstop.next_stop, 2)
        nt.eq_(tourstop.previous_stop, '')
        nt.eq_(tourstop.stop_link, '/tour/battle-of-atlanta/1')
        nt.eq_(tourstop.direction_modes, ['DRIVING', 'BICYCLING'])
        nt.eq_(tourstop.geospatial, True)
        nt.eq_(tourstop.intro, True)
        nt.eq_(tourstop.description, 'A stop in atlanta for the tour')
        nt.eq_(tourstop.tour.name, 'Battle of Atlanta')
        nt.eq_(tourstop.position, 0)
        nt.eq_(tourstop.slug, 'atlanta')
        nt.eq_(tourstop.lat, 33)
        nt.eq_(tourstop.lng, -84)
        nt.eq_(tourstop.park_lat, 33)
        nt.eq_(tourstop.park_lng, -84)
        nt.eq_(tourstop.directions_intro, 'some intro for directions')
        nt.eq_(tourstop.direction_notes, 'some notes for directions')
        nt.eq_(tourstop.video_embed, '1a2b3c4d')

        nt.eq_(tourstop.phone_poster, 'example.com/media/stops/phone/250-250-puft_vs_godzilla.png')
        poster = Image.open('%s/stops/%s' % (settings.MEDIA_ROOT, tourstop.phone_poster.split('/')[-1]))
        nt.eq_(poster.size, (1600, 1244))

class TourInfoTestCase(DjangoTestCase):
    fixtures = ["tours", "tour_info"]

    def test_init(self):
        tourinfo = TourInfo.objects.get(pk=1)
        nt.assert_true(isinstance(tourinfo, TourInfo))
        nt.eq_(tourinfo.icon, 'fa-info-circle')
        nt.eq_(tourinfo.name, 'About')
        nt.eq_(tourinfo.tour.name, 'Battle of Atlanta')
        nt.eq_(tourinfo.position, 0)
        nt.eq_(tourinfo.info_slug, 'about')

class TourStopMediaCase(DjangoTestCase):
    fixtures = ["tours", "tour_stops", "tour_stop_media"]

    def test_init(self):
        stop_media = TourStopMedia.objects.get(pk=1)
        nt.assert_true(isinstance(stop_media, TourStopMedia))
        nt.eq_(stop_media.label, 'sharknado-1')
        nt.eq_(stop_media.href, '#sharknado-1')
        nt.eq_(stop_media.size, '596.2 kB')

        nt.eq_(stop_media.original_image, 'example.com/media/stops/sharknado.jpg')

        nt.eq_(stop_media.phone_thumb, 'example.com/media/stops/phone/250-250-sharknado.jpg')
        phone_thumb_image = Image.open('%s/stops/phone/%s' % (settings.MEDIA_ROOT, stop_media.phone_thumb.split('/')[-1]))
        nt.eq_(phone_thumb_image.size, (175, 250))

        nt.eq_(stop_media.tablet_thumb, 'example.com/media/stops/tablet/400-400-sharknado.jpg')
        tablet_thumb_image = Image.open('%s/stops/tablet/%s' % (settings.MEDIA_ROOT, stop_media.tablet_thumb.split('/')[-1]))
        nt.eq_(tablet_thumb_image.size, (280, 400))

        nt.eq_(stop_media.desktop_thumb, 'example.com/media/stops/desktop/600-600-sharknado.jpg')
        desktop_thumb_image = Image.open('%s/stops/desktop/%s' % (settings.MEDIA_ROOT, stop_media.desktop_thumb.split('/')[-1]))
        nt.eq_(desktop_thumb_image.size, (421, 600))

        nt.eq_(stop_media.phone_full, 'example.com/media/stops/phone_full/585-585-sharknado.jpg')
        phone_full_image = Image.open('%s/stops/phone_full/%s' % (settings.MEDIA_ROOT, stop_media.phone_full.split('/')[-1]))
        nt.eq_(phone_full_image.size, (410, 585))

        nt.eq_(stop_media.tablet_full, 'example.com/media/stops/tablet_full/800-800-sharknado.jpg')
        tablet_full_image = Image.open('%s/stops/tablet_full/%s' % (settings.MEDIA_ROOT, stop_media.tablet_full.split('/')[-1]))
        nt.eq_(tablet_full_image.size, (561, 800))

        nt.eq_(stop_media.desktop_full, 'example.com/media/stops/desktop_full/1200-1200-sharknado.jpg')
        desktop_full_image = Image.open('%s/stops/desktop_full/%s' % (settings.MEDIA_ROOT, stop_media.desktop_full.split('/')[-1]))
        nt.eq_(desktop_full_image.size, (841, 1200))

        shutil.rmtree('%s/stops/phone' % settings.MEDIA_ROOT)
        shutil.rmtree('%s/stops/tablet' % settings.MEDIA_ROOT)
        shutil.rmtree('%s/stops/desktop' % settings.MEDIA_ROOT)
        shutil.rmtree('%s/stops/phone_full' % settings.MEDIA_ROOT)
        shutil.rmtree('%s/stops/tablet_full' % settings.MEDIA_ROOT)
        shutil.rmtree('%s/stops/desktop_full' % settings.MEDIA_ROOT)
