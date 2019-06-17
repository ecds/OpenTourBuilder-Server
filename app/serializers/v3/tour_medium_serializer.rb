# frozen_string_literal: true

class V3::TourMediumSerializer < ActiveModel::Serializer
  belongs_to :tour
  belongs_to :medium
  attributes :id, :position
end
