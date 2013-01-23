# file battleofatlanta/apps/tour/admin.py

from django.contrib import admin

from django_admin_bootstrapped.admin.models import SortableInline, CollapsibleInline

from battleofatlanta.apps.tour.models import Tour, TourStop, TourStopMedia

# class TourStopInline(admin.TabularInline, SortableInline):
class TourStopInline(admin.StackedInline, SortableInline, CollapsibleInline):
    model = TourStop
    extra = 0
    start_collapsed = True

class TourAdmin(admin.ModelAdmin):
    inlines = ( TourStopInline, )

admin.site.register(TourStopMedia)
admin.site.register(TourStop)
admin.site.register(Tour, TourAdmin)