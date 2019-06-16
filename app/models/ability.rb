# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    can :read, Tour, published: true
    can :read, Theme
    can :read, Mode
    can :read, TourMode
    can :read, Stop
    can :read, TourStop
    can :read, TourMedium
    can :read, StopMedium
    can :read, Medium
    can :read, FlatPage
    can [:read], TourSet
    return unless user.present?
    can [:read, :edit, :update], Tour
    can [:manage], TourMedium
    can [:manage], Medium
    can [:manage], TourStop
    can [:manage], Stop
    can [:manage], StopMedium
    can [:manage], FlatPage
    can [:manage], TourFlatPage
    can [:read], User
    return unless user.current_tenant_admin?
    can [:manage], Tour
    # can :manage, Stop
    # can :manage, TourStop
    # can :manage, TourMedium
    # can :manage, StopMedium
    # can :manage, Medium
    # can :manage, FlatPage
    return unless user.super
    can :manage, :all
  end
end
