# frozen_string_literal: true

class User < ActiveRecord::Base
  include EcdsRailsAuthEngine::EcdsUser
  has_many :tour_set_admins
  has_many :tour_sets, through: :tour_set_admins
  has_many :tour_authors
  has_many :tours, through: :tour_authors

  #
  # Gets role for current tenant
  #
  # @return [Role] Role object
  #
  def current_tenant_admin?
    return true if self.super
    return if tour_sets.empty?
    tour_sets.collect(&:subdir).include? Apartment::Tenant.current
  end
end


