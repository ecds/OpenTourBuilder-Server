# frozen_string_literal: true

# app/controllers/v1/tours_controller.rb
# This is only for testing calls to versioned endpoints.
class V1::ToursController < ApplicationController
  def index
    json_response(message: Faker::Movies::HitchhikersGuideToTheGalaxy.quote)
  end
end
