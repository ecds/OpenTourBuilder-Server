# frozen_string_literal: true

# app/serializers/tour_serializer.rb
class V3::TourSerializer < ActiveModel::Serializer
  has_many :tour_stops
  has_many :stops
  belongs_to :mode
  belongs_to :theme
  has_many :modes
  has_many :media
  has_many :tour_media
  has_many :flat_pages
  has_many :tour_flat_pages
  attributes :id, :title, :slug, :description, :is_geo, :published, :sanitized_description, :position, :theme_title, :meta_description, :splash, :tenant, :tenant_title, :stop_count, :map_type, :external_url, :splash_width, :splash_height, :insecure_splash
end
