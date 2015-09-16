from django.core.management.base import BaseCommand, CommandError
from django.contrib.sites.models import Site
from re import sub

class Command(BaseCommand):
    help = "Sets the site to the new domain."

    def add_arguments(self, parser):
        parser.add_argument('domain', nargs='+', type=str)

    def handle(self, *args, **options):

        api_domain = options['domain'][0]

        api_domain = api_domain.replace("http://", "")
        api_domain = api_domain.replace("https://", "")
        api_domain = "http://api.%s" % api_domain

        site = Site.objects.get(pk=1)
        site.domain = api_domain
        site.name = api_domain
        site.save()
