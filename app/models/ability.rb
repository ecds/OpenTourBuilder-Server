# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Tour, published: true
    return unless user.present?
    can [:edit, :update], user.tours
    return unless user.current_tenant_admin?
    can :manage, Tour
    return unless user.super
    can :manage, :all
  end
end
