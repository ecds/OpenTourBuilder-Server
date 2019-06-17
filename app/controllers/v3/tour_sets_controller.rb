# frozen_string_literal: true

# Controller class for Tour Sets
# app/controllers/v3/tour_sets.rb
module V3
  class TourSetsController < V3Controller
    before_action :set_tour_set, only: [:show, :update, :destroy]
    authorize_resource

    # GET /tour_sets
    def index
      @tour_sets = []
      if params[:subdir]
        @tour_sets = TourSet.find_by(subdir: params[:subdir])
      elsif current_user.super
        @tour_sets = TourSet.all
      elsif current_user.id.present?
        @tour_sets = current_user.tour_sets
      else
        #TourSet.all.reject {|ts| p ts.tours.empty?}
        @tour_sets = TourSet.all.reject { |ts| ts.published_tours.empty? }
      end
  
      if current_user.current_tenant_admin? || current_user.super
        render json: @tour_sets, include: [ 'admins' ]
      else
        render json: @tour_sets
      end
    end

    # GET /tour_sets/1
    def show
      render json: @tour_set
    end

    # POST /tour_sets
    def create
      @tour_set = TourSet.new(tour_set_params)

      if @tour_set.save
        # render json: @tour_set, status: :created, location: @tour_set
        response = render json: @tour_set, status: :created, location: "/#{Apartment::Tenant.current}/#{@tour_set.id}"
        return response
      else
        render json: @tour_set.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /tour_sets/1
    def update
      if @tour_set.update(tour_set_params)
        # render json: @tour_set
        head :no_content
      else
        render json: @tour_set.errors, status: :unprocessable_entity
      end
    end

    # DELETE /tour_sets/1
    def destroy
      @tour_set.destroy
    end

  private

    # Use callbacks to share common setup or constraints between actions.
    def set_tour_set
      @tour_set = TourSet.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tour_set_params
      ActiveModelSerializers::Deserialization
          .jsonapi_parse(
            params, only: [
                  :name, :tours, :admins
              ]
          )
    end
  end
end
