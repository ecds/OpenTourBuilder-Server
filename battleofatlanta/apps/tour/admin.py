from django.contrib import admin

from django_admin_bootstrapped.admin.models import SortableInline, CollapsibleInline

from battleofatlanta.apps.tour.models import Tour, TourStop

# class TourStopInline(admin.TabularInline, SortableInline):
class TourStopInline(admin.StackedInline, SortableInline, CollapsibleInline):
    model = TourStop
    extra = 0
    start_collapsed = True

class TourAdmin(admin.ModelAdmin):
    inlines = ( TourStopInline, )
    # collapse our stacked inlines by default
    # class Media:
    #     js = (
    #         '/static/admin/js/collapse-inlines.js',
    #     )

admin.site.register(Tour, TourAdmin)
# admin.site.register(TourStop)