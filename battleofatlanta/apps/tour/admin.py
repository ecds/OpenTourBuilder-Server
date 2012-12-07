from django.contrib import admin

from battleofatlanta.apps.tour.models import Tour, TourStop

class TourStopInline(admin.TabularInline):
    model = TourStop
    extra = 1

class TourAdmin(admin.ModelAdmin):
    inlines = ( TourStopInline, )

admin.site.register(Tour, TourAdmin)
admin.site.register(TourStop)