import os
import sys

DJANGO_SETTINGS_MODULE='tours.settings'

os.environ['DJANGO_SETTINGS_MODULE'] = 'tours.settings'

from django.core.wsgi import get_wsgi_application
application = get_wsgi_application()


