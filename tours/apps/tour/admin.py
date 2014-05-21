# file tours/apps/tour/admin.py

from django.contrib import admin

from django_admin_bootstrapped.admin.models import SortableInline, CollapsibleInline

from tours.apps.tour.models import Tour, TourInfo, TourStop, TourStopMedia, DirectionsMode

class TourStopMediaInline(admin.StackedInline, SortableInline, CollapsibleInline):
    model = TourStopMedia
    extra = 0
    start_collapsed = True
#    exclude = ('thumbnail',)

class TourStopMediaAdmin(admin.ModelAdmin):
    exclude = ('inline',)

class TourInfoInline(admin.StackedInline, SortableInline, CollapsibleInline):
    model = TourInfo
    extra = 0
    start_collapsed = True
#    exclude = ('position',)

class TourInfoAdmin(admin.ModelAdmin):
    list_filter = ('tour',)
    exclude = ('position',)

class TourStopInline(admin.StackedInline, SortableInline, CollapsibleInline):
    model = TourStop
    extra = 0
    start_collapsed = True
#    exclude = ('position',)

class TourStopAdmin(admin.ModelAdmin):
    list_filter = ('tour',)
    inlines = ( TourStopMediaInline, )
    exclude = ('position',)

class TourAdmin(admin.ModelAdmin):
    inlines = ( TourInfoInline, TourStopInline, )

#class DirectionsMode(admin.ModelAdmin):
#    extra = 0

#class TourStopMediaTypeAdmin(admin.ModelAdmin):
#    model = TourStopMediaType

admin.site.register(TourStopMedia, TourStopMediaAdmin)
admin.site.register(TourInfo, TourInfoAdmin)
admin.site.register(TourStop, TourStopAdmin)
admin.site.register(Tour, TourAdmin)
admin.site.register(DirectionsMode)
#admin.site.register(TourStopMediaType, TourStopMediaTypeAdmin)
