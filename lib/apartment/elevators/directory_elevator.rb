# frozen_string_literal: true

# module Apartment
#   module Elevators
    class DirectoryElevator < Apartment::Elevators::Generic
      def parse_tenant_name(request)
        # request is an instance of Rack::Request
        tenant_name = TourCollection.subdomain(request.fullpath.split('/')[1])

        tenant_name
      end
  #   end
  # end
end
