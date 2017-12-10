# frozen_string_literal: true

# /app/controllers/v3/tour_stops_controller.rb
class V3::TourStopsController < ApplicationController
  before_action :set_tour_stop, only: [:show, :update, :destroy]

  # GET /stops
  def index
    @tour_stops = TourStop.all
    render json: @tour_stops
  end

  # GET /stops/1
  def show
    render json: @tour_stop, include: ['stop']
  end

  # POST /stops
  def create
    @tour_stop = Stop.new(tour_stop_params)
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
        params.require(:tour_stop).permit(:title, :description, :lat, :lng, :metadescription, :article_link, :video_embed, :video_poster, :lat, :lng, :parking_lat, :parking_lng, :direction_intro, :direction_notes)
      end

      def set_tour_stop
        @tour_stop = TourStop.find_by!(id: params[:id])
      end
end
