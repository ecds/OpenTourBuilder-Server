# frozen_string_literal: true

class V3::TourSetSerializer < ActiveModel::Serializer
  # has_many :tours
  attributes :id, :name, :subdir
end
