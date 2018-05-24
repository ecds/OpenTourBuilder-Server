# frozen_string_literal: true

module V3
  class TourSetUsersController < V3Controller
    before_action :set_tour_set_user, only: [:show, :update, :destroy]
    authorize_resource

    # GET /tour_set_users
    def index
      @tour_set_users = TourSetUser.all

      render json: @tour_set_users
    end

    # GET /tour_set_users/1
    def show
      render json: @tour_set_user
    end

    # POST /tour_set_users
    def create
      @tour_set_user = TourSetUser.new(tour_set_user_params)

      if @tour_set_user.save
        render json: @tour_set_user, status: :created, location: @tour_set_user
      else
        render json: @tour_set_user.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /tour_set_users/1
    def update
      if @tour_set_user.update(tour_set_user_params)
        render json: @tour_set_user
      else
        render json: @tour_set_user.errors, status: :unprocessable_entity
      end
    end

    # DELETE /tour_set_users/1
    def destroy
      @tour_set_user.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_tour_set_user
        @tour_set_user = TourSetUser.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def tour_set_user_params
        params.fetch(:tour_set_user, {})
      end
  end
end
