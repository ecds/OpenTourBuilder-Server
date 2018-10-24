# frozen_string_literal: true

# app/serializer/user_serializer.rb
class V3::UserSerializer < ActiveModel::Serializer
  has_one :login
  has_many :tours
  has_many :tour_sets
  attributes :id, :display_name, :super, :login
end
