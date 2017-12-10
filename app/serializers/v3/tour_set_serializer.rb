# frozen_string_literal: true

class V3::TourSetSerializer < ActiveModel::Serializer
  belongs_to :stop
  belongs_to :tour
  attributes :id, :name
end
