# app/serializer/user_serializer.rb
class UserSerializer < ActiveModel::Serializer
    attributes :id, :displayname

    has_one :login
end
