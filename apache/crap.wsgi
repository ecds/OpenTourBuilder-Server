import os
import sys
import site

# Add the site-packages of the chosen virtualenv to work with
site.addsitedir('/data/django/tours/venv/lib/python2.7/site-packages')

# Add the app's directory to the PYTHONPATH
sys.path.append('/data/django/tours')
sys.path.append('/data/django/tours/tours')

os.environ['DJANGO_SETTINGS_MODULE'] = 'tours.settings'

# Activate your virtual env
activate_env=os.path.expanduser("/data/django/tours/venv/bin/activate")
execfile(activate_env, dict(__file__=activate_env))

import django.core.handlers.wsgi
application = django.core.handlers.wsgi.WSGIHandler()
