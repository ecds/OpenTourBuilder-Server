# file battleofatlanta/settings/__init__.py
import os

from .base import *

if not os.environ.get('USE_TEST_SETTINGS'):
    try:
        from .local import *
    except ImportError, exc:
        exc.args = tuple(
            ['%s (did you rename settings/local-dist.py?)' % exc.args[0]])
        raise exc

if os.environ.get('USE_TEST_SETTINGS'):
    try:
        from .test import *
    except ImportError, exc:
        exc.args = tuple(
            ['%s (did you rename settings/test.py?)' % exc.args[0]])
        raise exc