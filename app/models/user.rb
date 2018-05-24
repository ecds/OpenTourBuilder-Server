# frozen_string_literal: true

class User < ActiveRecord::Base
  include EcdsAuthEngine::EcdsUser
  has_many :tour_set_users
  has_many :tour_sets, through: :tour_set_users

  #
  # Gets role for current tenant
  #
  # @return [Role] Role object
  #
  def current_role
    if role_in_current
      tour_set_users.where(tour_set: TourSet.where(subdomain: Apartment::Tenant.current).first).where(user: self).first.role
    else
      Role.new(title: 'Guest')
    end
  end

  private

    #
    # Check for role in current tenant
    #
    # @return [<boolean>] Check to see if user has role in current tenant
    #
    def role_in_current
      tour_sets.pluck(:subdomain).include? Apartment::Tenant.current
    end
end
