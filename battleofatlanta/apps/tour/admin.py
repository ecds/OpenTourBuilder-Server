# file battleofatlanta/apps/tour/admin.py

from django.contrib import admin

from django_admin_bootstrapped.admin.models import SortableInline, CollapsibleInline

from battleofatlanta.apps.tour.models import Tour, TourStop, TourStopMedia, TourSplashImage

class TourStopMediaInline(admin.TabularInline, SortableInline):
    model = TourStopMedia
    extra = 1
#    exclude = ('thumbnail',)

class TourStopMediaAdmin(admin.ModelAdmin):
    exclude = ('inline',)

class TourStopInline(admin.StackedInline, SortableInline, CollapsibleInline):
    model = TourStop
    extra = 0
    start_collapsed = True

class TourSplashImageInline(admin.StackedInline, CollapsibleInline):
	model = TourSplashImage
	extra = 0

class TourStopAdmin(admin.ModelAdmin):
    inlines = ( TourStopMediaInline, )

class TourAdmin(admin.ModelAdmin):
    inlines = ( TourStopInline, TourSplashImageInline )

#class TourStopMediaTypeAdmin(admin.ModelAdmin):
#    model = TourStopMediaType

admin.site.register(TourStopMedia, TourStopMediaAdmin)
admin.site.register(TourStop, TourStopAdmin)
admin.site.register(Tour, TourAdmin)
#admin.site.register(TourStopMediaType, TourStopMediaTypeAdmin)
