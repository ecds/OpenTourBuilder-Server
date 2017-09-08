# app/controllers/v3/tours_controller.rb
# module V3
class V3::ToursController < ApplicationController
    before_action :set_tour, only: [:show, :update, :destroy]

    # GET /tours
    def index
        @tours = Tour.all

        render json: @tours
    end

    # GET /tours/1
    def show
        render json: @tour
    end

    # POST /tours
    def create
        @tour = Tour.new(tour_params)
        if @tour.save
            render json: @tour, status: :created, location: @tour
        else
            render json: @tour.errors, status: :unprocessable_entity
        end
    end

    # PATCH/PUT /tours/1
    def update
        if @tour.update(tour_params)
            # render json: @tour
            head :no_content
        else
            render json: @tour.errors, status: :unprocessable_entity
        end
    end

    # DELETE /tours/1
    def destroy
        @tour.destroy
    end

    private

    # Use callbacks to share common setup or constraints between actions.
    def set_tour
        @tour = Tour.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tour_params
        ActiveModelSerializers::Deserialization
            .jsonapi_parse(
                params, only: [
                    :title, :description, :splash_image,
                    :is_geo, :modes, :published, :theme_id,
                    :mode_id
                ]
            )
    end
end
# end
