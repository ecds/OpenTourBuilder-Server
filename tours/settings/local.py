# file tours/settings/local.py

DATABASES = {
    'default': {
        'ENGINE': 'django.db.backends.mysql', # Add 'postgresql_psycopg2', 'mysql', 'sqlite3' or 'oracle'.
        'NAME': 'boa-dev',                      # Or path to database file if using sqlite3.
        'USER': 'boa2',                      # Not used with sqlite3.
        'PASSWORD': 'W6yokh4j19GUoIjk',                  # Not used with sqlite3.
        'HOST': 'localhost',                      # Set to empty string for localhost. Not used with sqlite3.
        'PORT': '',                      # Set to empty string for default. Not used with sqlite3.
    }
}

SUB_URL = '/'

