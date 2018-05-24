# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.super
      can :manage, :all
    elsif user.current_role.title == 'Author'
      can :manage, [Tour, Stop, Medium, FlatPage, StopMedium, TourMedium, TourStop, StopMedium]
      can :read, User, id: user.id
    else
      can :read, Tour, published: true
      can :read, Stop, is_published: true
      # can :read, Medium, is_published?: true
      can :read, [FlatPage, Mode, Theme, TourStop, StopMedium, TourSet]
      can :read, Medium, published: true
      can :read, User
      can :manage, [Login, Oauth2Controller]
    end
  end
end
