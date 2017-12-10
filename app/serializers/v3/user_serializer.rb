# frozen_string_literal: true

# app/serializer/user_serializer.rb
class V3::UserSerializer < ActiveModel::Serializer
  attributes :id, :displayname

  # has_one :login
end
