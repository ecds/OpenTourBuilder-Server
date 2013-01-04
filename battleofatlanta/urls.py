from django.conf.urls import patterns, include, url

# Uncomment the next two lines to enable the admin:
from django.contrib import admin
admin.autodiscover()

urlpatterns = patterns('',
    # Examples:
    url(r'^$', 'battleofatlanta.apps.common.views.site_index', name='site_index'),

    url(r'^tour/', include('battleofatlanta.apps.tour.urls', namespace="tour")),
    # url(r'^battleofatlanta/', include('battleofatlanta.foo.urls')),

    # Uncomment the admin/doc line below to enable admin documentation:
    url(r'^admin/doc/', include('django.contrib.admindocs.urls')),

    # Uncomment the next line to enable the admin:
    url(r'^admin/', include(admin.site.urls)),

    # TinyMCE urls for WYSIWYG editing
    (r'^tinymce/', include('tinymce.urls')),
)
