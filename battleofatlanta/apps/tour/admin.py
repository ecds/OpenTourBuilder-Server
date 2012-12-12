from django.contrib import admin

from battleofatlanta.apps.tour.models import Tour, TourStop

class TourStopInline(admin.StackedInline):
    model = TourStop
    extra = 1

class TourAdmin(admin.ModelAdmin):
    inlines = ( TourStopInline, )

    # collapse our stacked inlines by default
    class Media:
        js = ('/static/js/admin/collapse-inlines.js',)

admin.site.register(Tour, TourAdmin)
admin.site.register(TourStop)