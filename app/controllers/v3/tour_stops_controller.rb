# frozen_string_literal: true

# /app/controllers/v3/tour_stops_controller.rb
class V3::TourStopsController < V3Controller
  before_action :set_tour_stop, only: [:show, :update, :destroy]
  authorize_resource

  # GET /stops
  def index
    @tour_stops = if params[:tour_id] && params[:stop_id]
      TourStop.where(tour: Tour.find(params[:tour_id])).where(stop: Stop.find(params[:stop_id])).first || {}
    elsif params[:tour] && params[:slug]
      stop = StopSlug.find_by(slug: params[:slug])
      TourStop.where(tour: Tour.find(params[:tour])).where(stop: stop.stop).first
    else
      TourStop.all
    end
    render json: @tour_stops, include: ['stop']
  end

  # GET /stops/1
  def show
    render json: @tour_stop, include: ['stop']
  end

  # POST /stops
  def create
    @tour_stop = TourStop.new(tour_stop_params)
    if @tour_stop.save
      render json: @tour_stop, status: :created, location: @tour_stop
    else
      render json: @tour_stop.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stops/1
  def update
    if @tour_stop.update(tour_stop_params)
      # render json: @stop
      head :no_content
    else
      render json: @tour_stop.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stops/1
  def destroy
    @tour_stop.destroy
  end

    private

      # Only allow a trusted parameter "white list" through.
      def tour_stop_params
        ActiveModelSerializers::Deserialization
            .jsonapi_parse(
              params, only: [
                    :stop, :tour, :position
                ]
            )
      end

      def set_tour_stop
        @tour_stop = TourStop.find_by!(id: params[:id])
      end
end
