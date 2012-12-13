from django.contrib import admin

from battleofatlanta.apps.tour.models import Tour, TourStop

class TourStopInline(admin.StackedInline):
    model = TourStop
    extra = 1

    sortable_field_name = "position"

class TourAdmin(admin.ModelAdmin):
    inlines = ( TourStopInline, )

    # collapse our stacked inlines by default
    class Media:
        js = (
            '/static/admin/js/jquery-ui-1.9.2.custom.min.js',
            '/static/admin/js/collapse-inlines.js',
        )

admin.site.register(Tour, TourAdmin)
admin.site.register(TourStop)