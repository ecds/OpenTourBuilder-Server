# frozen_string_literal: true

class V3::FlatPagesController < V3Controller
  before_action :set_flat_page, only: [:show, :update, :destroy]
  authorize_resource

  # GET /v3/flat_pages
  def index
    @flat_pages = FlatPage.all

    render json: @flat_pages
  end

  # GET /v3/flat_pages/1
  def show
    render json: @flat_page
  end

  # POST /v3/flat_pages
  def create
    @flat_page = FlatPage.new(flat_page_params)

    if @flat_page.save
      render json: @flat_page, status: :created, location: "/#{Apartment::Tenant.current}/flat-pages/#{@flat_page.id}"
    else
      render json: @flat_page.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v3/flat_pages/1
  def update
    if @flat_page.update(flat_page_params)
      render json: @flat_page
    else
      render json: @flat_page.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v3/flat_pages/1
  def destroy
    @flat_page.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flat_page
      @flat_page = FlatPage.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def flat_page_params
      ActiveModelSerializers::Deserialization
          .jsonapi_parse(
            params, only: [
                  :title, :content, :tours
              ]
          )
    end
end
