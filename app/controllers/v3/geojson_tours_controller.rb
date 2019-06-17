# frozen_string_literal: true

#
# <Description>
#
module V3
  class GeojsonToursController < V3Controller
    skip_authorization_check
    def show
      @tour = Tour.find(params[:id])
      render json: { type: 'FeatureCollection', features: @tour.stops.map { |s| feature(s) } }.to_json
    end

    private

      def feature(stop)
        {
          type: 'Feature',
          geometry: {
              type: 'Point',
              coordinates: [stop.lng.to_f, stop.lat.to_f]
            },
            properties: {
              title: stop.title,
              description: stop.description,
              images: stop.media.map(&:mobile).map { |m| "#{request.protocol}#{request.host}/#{m}" }
            }
        }
      end
  end
end
