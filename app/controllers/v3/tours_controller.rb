# frozen_string_literal: true

# app/controllers/v3/tours_controller.rb
# module V3
class V3::ToursController < V3Controller
  before_action :set_tour, only: [:show, :update, :destroy]
  authorize_resource

  # GET /tours
  def index
    @tours = []
    if current_user.present? && current_user.current_role.title != 'Guest'
      @tours = Tour.all
    else
      @tours = Tour.published
    end

    if @tours.length == 0
      return head :no_content
    end

    render json: @tours,
            include: [
                'tour_stops',
                'stops',
                'mode',
                'modes',
                'theme',
                'media'
            ]
  end

  # GET /tours/1
  def show
    render json: @tour,
           include: [
               'tour_stops',
               'stops',
               'mode',
               'modes',
               'theme',
               'media',
               'tour_media',
               'flat_pages'
           ]
  end

  # POST /tours
  def create
    @tour = Tour.new(tour_params)
    if @tour.save
      response = render json: @tour, status: :created, location: "/#{Apartment::Tenant.current}/tours/#{@tour.id}"
      return response
    else
      render json: @tour.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tours/1
  def update
    if @tour.update(tour_params)
      render json: @tour, location: "/#{Apartment::Tenant.current}/tours/#{@tour.id}"
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
        @tour = Tour.includes(:tour_stops).find(params[:id])
      end

      # Only allow a trusted parameter "white list" through.
      def tour_params
        ActiveModelSerializers::Deserialization
            .jsonapi_parse(
              params, only: [
                    :title, :description,
                    :is_geo, :modes, :published, :theme_id,
                    :mode_id, :media, :meta_description
                ]
            )
      end
end
