# /app/controllers/v3/stops_controller.rb
module V3
class StopsController < ApplicationController
    before_action :set_tour
    before_action :set_tour_stop, only: [:show, :update, :destroy]

    # GET /stops
    def index
        @stops = Stop.all

        render json: @stops
    end

    # GET /stops/1
    def show
        render json: @stop
    end

    # POST /stops
    def create
        @tour.stops.new(stop_params)

        if @tour.save
            render json: @stop, status: :created, location: @stop
        else
            render json: @stop.errors, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /stops/1
    def update
        if @stop.update(stop_params)
            # render json: @stop
            head :no_content
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
        params.require(:stop).permit(:title, :description, :lat, :lng, :metadescription, :article_link, :video_embed, :video_poster, :lat, :lng, :parking_lat, :parking_lng, :direction_intro, :direction_notes)
    end

    # Use callbacks to share common setup or constraints between actions.

    def set_tour
        @tour = Tour.find(params[:tour_id])
    end

    def set_tour_stop
        @stop = @tour.stops.find_by!(id: params[:id]) if @tour
    end


end
end
