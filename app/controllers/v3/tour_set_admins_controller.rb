# frozen_string_literal: true

module V3
  class TourSetAdminsController < V3Controller
    before_action :set_tour_set_admin, only: [:show, :update, :destroy]
    authorize_resource

    # GET /tour_set_admins
    def index
      @tour_set_admins = TourSetAdmin.all

      render json: @tour_set_admins
    end

    # GET /tour_set_admins/1
    def show
      render json: @tour_set_admin
    end

    # POST /tour_set_admins
    def create
      @tour_set_admin = TourSetAdmin.new(tour_set_admin_params)

      if @tour_set_admin.save
        render json: @tour_set_admin, status: :created, location: @tour_set_admin
      else
        render json: @tour_set_admin.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /tour_set_admins/1
    def update
      if @tour_set_admin.update(tour_set_admin_params)
        render json: @tour_set_admin
      else
        render json: @tour_set_admin.errors, status: :unprocessable_entity
      end
    end

    # DELETE /tour_set_admins/1
    def destroy
      @tour_set_admin.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_tour_set_admin
        @tour_set_admin = TourSetAdmin.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def tour_set_admin_params
        params.fetch(:tour_set_admin, {})
      end
  end
end
