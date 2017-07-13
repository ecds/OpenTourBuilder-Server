# app/controllers/authenticated_controller.rb
class AuthenticatedController < ApplicationController
    include RailsApiAuth::Authentication

    before_action :authenticate!

    def index
        render json: { success: true }
    end
end
