# app/serializers/tour_serializer.rb
class TourSerializer < ActiveModel::Serializer
    attributes :id, :title, :description, :splash_image, :is_geo, :modes, :published
end
