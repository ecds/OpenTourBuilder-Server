# frozen_string_literal: true

# app/serializers/tour_serializer.rb
class V3::TourSerializer < ActiveModel::Serializer
  has_many :tour_stops
  has_many :stops
  belongs_to :mode
  belongs_to :theme
  has_many :modes
  attributes :id, :title, :description, :splash_image, :is_geo, :published, :video, :sanitized_description
end
