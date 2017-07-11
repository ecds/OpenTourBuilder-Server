class StopTagsController < ApplicationController
  before_action :set_stop_tag, only: [:show, :update, :destroy]

  # GET /stop_tags
  def index
    @stop_tags = StopTag.all

    render json: @stop_tags
  end

  # GET /stop_tags/1
  def show
    render json: @stop_tag
  end

  # POST /stop_tags
  def create
    @stop_tag = StopTag.new(stop_tag_params)

    if @stop_tag.save
      render json: @stop_tag, status: :created, location: @stop_tag
    else
      render json: @stop_tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /stop_tags/1
  def update
    if @stop_tag.update(stop_tag_params)
      render json: @stop_tag
    else
      render json: @stop_tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /stop_tags/1
  def destroy
    @stop_tag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_stop_tag
      @stop_tag = StopTag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def stop_tag_params
      params.fetch(:stop_tag, {})
    end
end
