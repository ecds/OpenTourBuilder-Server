# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Tour, published: true
    can :read, Theme
    can :read, Stop
    can :read, TourStop
    can :read, TourMedium
    can :read, StopMedium
    can :read, Medium
    return unless user.present?
    can [:edit, :update], user.tours
    return unless user.current_tenant_admin?
    can :manage, Tour
    return unless user.super
    can :manage, :all
  end
end
