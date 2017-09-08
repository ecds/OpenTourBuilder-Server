# app/models/user.rb
class User < ApplicationRecord
    has_one :login

    attr_accessor :identification
    attr_accessor :password
    attr_accessor :uid
    attr_accessor :provider

    # before_create :create_login

    private

    def create_login
        login << Login.create(identification: identification, uid: uid, provider: provider, user: self)
    end
end
