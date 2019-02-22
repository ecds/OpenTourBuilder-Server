# frozen_string_literal: true

class User < ActiveRecord::Base
  include EcdsRailsAuthEngine::EcdsUser
  has_many :tour_set_admins
  has_many :tour_sets, through: :tour_set_admins
  has_many :tour_authors
  has_many :tours, through: :tour_authors

  scope :search, -> (search) { joins(:login).where("users.display_name ILIKE '%#{search}%' OR logins.identification ILIKE '%#{search}%'")}

  #
  # Gets role for current tenant
  #
  # @return [Role] Role object
  #
  def current_tenant_admin?
    return true if self.super
    return false if tour_sets.empty?
    tour_sets.collect(&:subdir).include? Apartment::Tenant.current
  end
end


