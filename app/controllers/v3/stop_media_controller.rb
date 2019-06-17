class V3::StopMediaController < V3Controller
  before_action :set_stop_medium, only: [:show, :update, :destroy]
  authorize_resource

  # GET /v3/stop_media
  def index
    @stop_media = if params[:stop_id] && params[:medium_id]
      StopMedium.where(stop_id: params[:stop_id]).where(medium_id: params[:medium_id]).first || {}
    else
      StopMedium.all
    end

    render json: @stop_media
  end

  # GET /v3/stop_media/1
  def show
    render json: @stop_medium,
     include: [
        #  'media'
     ]
  end

  # POST /v3/stop_media
  def create
    @stop_medium = StopMedium.new(stop_medium_params)

    if @stop_medium.save
      render json: @stop_medium, status: :created, location: "/#{Apartment::Tenant.current}/stop-medium/#{@stop_medium.id}"
    else
      render json: @stop_medium.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /v3/stop_media/1
  def update
    if @stop_medium.update(stop_medium_params)
      render json: @stop_medium
    else
      render json: @stop_medium.errors, status: :unprocessable_entity
    end
  end

  # DELETE /v3/stop_media/1
  def destroy
    @stop_medium.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stop_medium
      @stop_medium = StopMedium.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def stop_medium_params
      ActiveModelSerializers::Deserialization
          .jsonapi_parse(
            params, only: [
                  :medium, :stop, :position, :medium_id, :stop_id
              ]
          )
    end

    def set_stop_medium
      @stop_medium = StopMedium.find_by!(id: params[:id])
    end
end
