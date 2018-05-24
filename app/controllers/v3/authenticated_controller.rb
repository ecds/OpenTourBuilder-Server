# frozen_string_literal: true

# app/controllers/v3/authenticated_controller.rb
module V3
  class AuthenticatedController < V3Controller
    # include RailsApiAuth::Authentication

    before_action :authenticate!

    def index
      render json: { success: true }
    end
  end
end
