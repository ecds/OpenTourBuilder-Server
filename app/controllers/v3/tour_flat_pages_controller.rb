# frozen_string_literal: true

class V3::TourFlatPagesController < V3Controller
  before_action :set_tour_flat_page, only: [:show, :update, :destroy]
  authorize_resource

  # GET /v3/tour_flat_pages
  def index
    @tour_flat_pages = TourFlatPage.all

    render json: @tour_flat_pages
  end

  # GET /v3/tour_flat_pages/1
  def show
    render json: @tour_flat_page
  end

  # POST /v3/tour_flat_pages
  def create
    @tour_flat_page = TourFlatPage.new(tour_flat_page_params)

    if @tour_flat_page.save
      render json: @tour_flat_page, status: :created, location: "/#{Apartment::Tenant.current}/flat-pages/#{@tour_flat_page.id}"
    else
      render json: @tour_flat_page.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v3/tour_flat_pages/1
  def update
    if @tour_flat_page.update(tour_flat_page_params)
      render json: @tour_flat_page
    else
      render json: @tour_flat_page.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v3/tour_flat_pages/1
  def destroy
    @tour_flat_page.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour_flat_page
      @tour_flat_page = TourFlatPage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tour_flat_page_params
      ActiveModelSerializers::Deserialization
          .jsonapi_parse(
            params, only: [
                  :tour, :flat_page, :position
              ]
          )
    end
end
