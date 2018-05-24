# frozen_string_literal: true

class V3::TourModesSerializer < ActiveModel::Serializer
  attributes :id, :tour_id, :mode_id
end
