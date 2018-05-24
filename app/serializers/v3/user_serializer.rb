# frozen_string_literal: true

# app/serializer/user_serializer.rb
class V3::UserSerializer < ActiveModel::Serializer
  attributes :id, :display_name

  # has_one :login
end
