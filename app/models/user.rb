# frozen_string_literal: true

# app/models/user.rb
class User < ApplicationRecord
  has_one :login

  attr_accessor :identification
  attr_accessor :password
  attr_accessor :uid
  attr_accessor :provider

    # after_create :create_login

    private

      def create_login
        puts 'foo'
        create_login!(identification: identification, uid: uid, provider: provider, user: self)
      end
end
