# frozen_string_literal: true

  class V3::TourCollectionsController < V3Controller
    before_action :set_tour_collection, only: [:show, :update, :destroy]
    authorize_resource

    # GET /v3/tour_collections
    def index
      @tour_collections = TourCollection.all

      render json: @tour_collections
    end

    # GET /v3/tour_collections/1
    def show
      render json: @tour_collection
    end

    # POST /v3/tour_collections
    def create
      @tour_collection = TourCollection.new(tour_collection_params)

      if @tour_collection.save
        render json: @tour_collection, status: :created, location: @tour_collection
      else
        render json: @tour_collection.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /v3/tour_collections/1
    def update
      if @tour_collection.update(tour_collection_params)
        render json: @tour_collection
      else
        render json: @tour_collection.errors, status: :unprocessable_entity
      end
    end

    # DELETE /v3/tour_collections/1
    def destroy
      @tour_collection.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_tour_collection
        @tour_collection = TourCollection.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def tour_collection_params
        params.fetch(:tour_collection, {})
      end
  end
