# app/serializers/tour_serializer.rb
class V3::TourSerializer < ActiveModel::Serializer
    belongs_to :mode
    has_many :modes
    attributes :id, :title, :description, :splash_image, :is_geo, :published
end
