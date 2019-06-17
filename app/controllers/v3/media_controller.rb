# frozen_string_literal: true

# app/controllers/v3/media_controller.rb
module V3
  class MediaController < V3Controller
    before_action :set_medium, only: [:show, :update, :destroy]
    authorize_resource
    # GET /media
    def index
      # TODO: This ins not ideal, we use these `not_in_*` scopes to make the list of media avaliable to add
      # to a stop or tour. But the paramerter does not make sense when just looking at it. Needs clearer language.
      @media = if params[:stop_id]
        Medium.not_in_stop(params[:stop_id]).or(Medium.no_stops)
      elsif params[:tour_id]
        Medium.not_in_tour(params[:tour_id]).or(Medium.no_tours)
      else
        Medium.all
      end
      render json: @media
    end
    
    # GET /media/1
    def show
      if @medium.published
        render json: @medium
      else
        head 401
      end
    end

    # POST /media
    def create
      @medium = Medium.new(medium_params)

      if @medium.save
        render json: @medium, status: :created, location: "/#{Apartment::Tenant.current}/media/#{@medium.id}"
      else
        render json: @medium.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /media/1
    def update
      if @medium.update(medium_params)
        render json: @medium
      else
        render json: @medium.errors, status: :unprocessable_entity
      end
    end

    # DELETE /media/1
    def destroy
      @medium.destroy
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_medium
        @medium = Medium.find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def medium_params
        ActiveModelSerializers::Deserialization
        .jsonapi_parse(
          params, only: [
                :title, :caption, :original_image, :stops, :tours, :video, :stop_id, :tour_id
            ]
        )
      end
  end
end
