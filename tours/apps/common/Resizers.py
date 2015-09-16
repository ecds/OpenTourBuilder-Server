from PIL import Image
import os
from django.conf import settings
from django.contrib.sites.models import Site

class Resize(object):

    def __init__(self, path):
        self.path = str(path)

    def resize(self, size, path, context):
        target_path = '%s/%s/%s-%s-%s' % ( \
            path.split('/')[0], context, size[0], size[1], path.split('/')[-1])
        
        target_dir = '%s/%s/%s' %( \
            settings.MEDIA_ROOT, path.split('/')[0], context)

        domain = Site.objects.get_current().domain

        image_path = '%s/%s' % ( \
            settings.MEDIA_ROOT, str(path))

        new_image_full_path = '%s/%s' % ( \
            settings.MEDIA_ROOT, target_path)

        if not os.path.exists(target_dir):
            os.makedirs(target_dir)

        if not os.path.isfile(new_image_full_path):
            try:
                im = Image.open(image_path)
                im.thumbnail(size, Image.ANTIALIAS)
                im.save(new_image_full_path)
            
            except IOError:
                return 'Error'

        return '%s/media/%s' % (domain, target_path)

    def splash_phone(self):
        size = 465, 465
        context = 'phone'
        return self.resize(size, self.path, context)

    def splash_tablet(self):
        size = 650, 650
        context = 'tablet'
        return self.resize(size, self.path, context)

    def splash_desktop(self):
        domain = Site.objects.get_current().domain
        return '%s/media/%s' % (domain, self.path)

    def gallery_phone(self):
        size = 250, 250
        context = 'phone'
        return self.resize(size, self.path, context)

    def gallery_tablet(self):
        size = 400, 400
        context = 'tablet'
        return self.resize(size, self.path, context)

    def gallery_desktop(self):
        size = 600, 600
        context = 'desktop'
        return self.resize(size, self.path, context)

    def phone_full(self):
        size = 585, 585
        context = 'phone_full'
        return self.resize(size, self.path, context)

    def tablet_full(self):
        size = 800, 800
        context = 'tablet_full'
        return self.resize(size, self.path, context)

    def desktop_full(self):
        size = 1200, 1200
        context = 'desktop_full'
        return self.resize(size, self.path, context)
