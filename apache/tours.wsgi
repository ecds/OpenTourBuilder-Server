import os
import sys

DJANGO_SETTINGS_MODULE='tours.settings'

os.environ['DJANGO_SETTINGS_MODULE'] = 'tours.settings'

from django.core.handlers.wsgi import WSGIHandler
application = WSGIHandler()


