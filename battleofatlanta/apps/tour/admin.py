from django.contrib import admin

from django_admin_bootstrapped.admin.models import SortableInline

from battleofatlanta.apps.tour.models import Tour, TourStop

# class TourStopInline(admin.TabularInline, SortableInline):
class TourStopInline(admin.StackedInline, SortableInline):
    model = TourStop
    extra = 1

class TourAdmin(admin.ModelAdmin):
    inlines = ( TourStopInline, )

    # collapse our stacked inlines by default
    class Media:
        js = (
            '/static/admin/js/collapse-inlines.js',
        )

admin.site.register(Tour, TourAdmin)
admin.site.register(TourStop)