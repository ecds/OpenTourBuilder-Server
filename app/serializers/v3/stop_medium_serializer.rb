# frozen_string_literal: true

class V3::StopMediumSerializer < ActiveModel::Serializer
  belongs_to :stop
  belongs_to :medium
  attributes :id, :position
end
