# frozen_string_literal: true

class V3::MediumSerializer < ActiveModel::Serializer
  attributes :id, :title, :caption, :original_image
end
