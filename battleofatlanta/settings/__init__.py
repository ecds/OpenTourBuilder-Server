# file battleofatlanta/settings/__init__.py

from .base import *

if not 'test' in sys.argv:
    try:
        from .local import *
    except ImportError, exc:
        exc.args = tuple(
            ['%s (did you rename settings/local-dist.py?)' % exc.args[0]])
        raise exc

if 'test' in sys.argv:
    try:
        from .test import *
    except ImportError, exc:
        exc.args = tuple(
            ['%s (did you rename settings/test.py?)' % exc.args[0]])
        raise exc