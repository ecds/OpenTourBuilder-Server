# file tours/apps/tour/admin.py

from django.contrib import admin
from functools import partial
from django_admin_bootstrapped.admin.models import SortableInline, CollapsibleInline

from tours.apps.tour.models import Tour, TourInfo, TourStop, TourStopMedia, DirectionsMode

class TourStopMediaInline(admin.StackedInline, SortableInline, CollapsibleInline):
    model = TourStopMedia
    extra = 0
    start_collapsed = True

class TourStopMediaAdmin(admin.ModelAdmin):
    exclude = ('inline', 'position')

class TourInfoInline(admin.StackedInline, SortableInline, CollapsibleInline):
    model = TourInfo
    extra = 0
    start_collapsed = True

class TourInfoAdmin(admin.ModelAdmin):
    list_filter = ('tour',)
    exclude = ('position',)

class TourStopInline(admin.StackedInline, SortableInline, CollapsibleInline):
    model = TourStop
    extra = 0
    start_collapsed = True

class TourStopAdmin(admin.ModelAdmin):
    list_filter = ('tour',)
    inlines = ( TourStopMediaInline,)
    exclude = ('position',)

class TourAdmin(admin.ModelAdmin):
    
    # def get_form(self, request, obj=None, **kwargs):
    #     kwargs['formfield_callback'] = partial(self.formfield_for_dbfield, request=request, obj=obj)
    #     return super(TourAdmin, self).get_form(request, obj, **kwargs)
    
    #def formfield_for_dbfield(self, field, **kwargs):
    #    if field.name == 'id':
    #        print(field.__dict__)
    
    def formfield_for_dbfield(self, db_field, **kwargs):
        if db_field.name != "default_mode":
            kwargs.pop('obj', None)
        return super(TourAdmin, self).formfield_for_dbfield(db_field, **kwargs)
    
    def formfield_for_choice_field(self, db_field, request, **kwargs):
        tour = kwargs.pop('obj', None)
        print(tour)
        if db_field.name == "default_mode":
            kwargs['choices'] = []
            modes = Tour.objects.filter(name = tour).values_list('modes__mode', flat = True)
            if modes is None:
                kwargs['choices'].insert(0, ('later', 'later'))
            else:
                for mode in modes:
                    kwargs['choices'].insert(0, (mode, mode))
        return super(TourAdmin, self).formfield_for_choice_field(db_field, request, **kwargs)
    
    inlines = ( TourInfoInline, TourStopInline, )

admin.site.register(TourStopMedia, TourStopMediaAdmin)
admin.site.register(TourInfo, TourInfoAdmin)
admin.site.register(TourStop, TourStopAdmin)
admin.site.register(Tour, TourAdmin)
admin.site.register(DirectionsMode)
