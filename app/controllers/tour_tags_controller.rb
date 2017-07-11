class TourTagsController < ApplicationController
  before_action :set_tour_tag, only: [:show, :update, :destroy]

  # GET /tour_tags
  def index
    @tour_tags = TourTag.all

    render json: @tour_tags
  end

  # GET /tour_tags/1
  def show
    render json: @tour_tag
  end

  # POST /tour_tags
  def create
    @tour_tag = TourTag.new(tour_tag_params)

    if @tour_tag.save
      render json: @tour_tag, status: :created, location: @tour_tag
    else
      render json: @tour_tag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tour_tags/1
  def update
    if @tour_tag.update(tour_tag_params)
      render json: @tour_tag
    else
      render json: @tour_tag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tour_tags/1
  def destroy
    @tour_tag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tour_tag
      @tour_tag = TourTag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tour_tag_params
      params.fetch(:tour_tag, {})
    end
end
