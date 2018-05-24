# frozen_string_literal: true

# app/controllers/v3/modes_controller.rb
module V3
  class ModesController < V3Controller
    before_action :set_mode, only: [:show, :update, :destroy]
    authorize_resource

    # GET /modes
    def index
      @modes = Mode.all

      render json: @modes
    end

    # GET /modes/1
    def show
      render json: @mode
    end

    # POST /modes
    def create
      @mode = Mode.new(mode_params)

      if @mode.save
        render json: @mode, status: :created, location: @mode
      else
        render json: @mode.errors, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /modes/1
    def update
      if @mode.update(mode_params)
        render json: @mode
      else
        render json: @mode.errors, status: :unprocessable_entity
      end
    end

    # DELETE /modes/1
    def destroy
      @mode.destroy
    end

      private

        # Use callbacks to share common setup or constraints between actions.
        def set_mode
          @mode = Mode.find(params[:id])
        end

        # Only allow a trusted parameter "white list" through.
        def mode_params
          params.require(:mode).permit(:title)
        end
  end
end
