# frozen_string_literal: true

# /app/controllers/v3/stops_controller.rb
# module V3
class V3::StopsController < V3Controller
  # before_action :set_tour
  before_action :set_stop, only: [:show, :update, :destroy]
  authorize_resource

  # GET /stops
  def index
    @stops = if params[:tour_id]
      Stop.not_in_tour(params[:tour_id]).or(Stop.no_tours)
    elsif params[:slug]
      stop = StopSlug.find_by(slug: params[:slug]).stop
    else
      Stop.all
    end
    render json: @stops,
    include: [
        'media',
        'stop_media'
    ]
  end

  # GET /stops/1
  def show
    render json: @stop,
           include: [
               'media',
               'stop_media'
           ]
  end

  # POST /stops
  def create
    @stop = Stop.new(stop_params)
    if @stop.save
      render json: @stop, status: :created, location: "/#{Apartment::Tenant.current}/#{@stop.id}"
    else
      render json: @stop.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stops/1
  def update
    if @stop.update(stop_params)
      render json: @stop, location: "/#{Apartment::Tenant.current}/stops/#{@stop.id}"
    else
      render json: @stop.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stops/1
  def destroy
    @stop.destroy
  end

    private

    # Only allow a trusted parameter "white list" through.
    def stop_params
      ActiveModelSerializers::Deserialization
          .jsonapi_parse(
            params, only: [
                  :title, :description, :lat, :lng,
                  :parking_lat, :parking_lng, :media,
                  :address, :tours, :direction_notes
              ]
          )
    end

    # Use callbacks to share common setup or constraints between actions.

    def set_tour
      @tour = Tour.find(params[:tour_id])
    end

    def set_stop
      @stop = Stop.find(params[:id])
    end

    def set_tour_stop
      @stop = @tour.stops.find_by!(id: params[:id]) if @tour
    end
end
