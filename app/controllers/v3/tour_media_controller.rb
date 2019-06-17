class V3::TourMediaController < V3Controller
  before_action :set_tour_medium, only: [:show, :update, :destroy]
  authorize_resource

  # GET /v3/tour_media
  def index
    @tour_media = if params[:tour_id] && params[:medium_id]
      TourMedium.where(tour_id: params[:tour_id]).where(medium_id: params[:medium_id]).first || {}
    else
      TourMedium.all
    end

    render json: @tour_media
  end

  # GET /v3/tour_media/1
  def show
    render json: @tour_medium
  end

  # POST /v3/tour_media
  def create
    @tour_medium = TourMedium.new(tour_medium_params)

    if @tour_medium.save
      render json: @tour_medium, status: :created, location: @tour_medium
    else
      render json: @tour_medium.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v3/tour_media/1
  def update
    if @tour_medium.update(tour_medium_params)
      render json: @tour_medium
    else
      render json: @tour_medium.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v3/tour_media/1
  def destroy
    @tour_medium.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour_medium
      @tour_medium = TourMedium.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tour_medium_params
      ActiveModelSerializers::Deserialization
          .jsonapi_parse(
            params, only: [
                  :medium, :tour, :position
              ]
          )
    end

    def set_tour_medium
      @tour_medium = TourMedium.find_by!(id: params[:id])
    end
end
