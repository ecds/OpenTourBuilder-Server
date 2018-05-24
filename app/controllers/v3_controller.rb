# frozen_string_literal: true

class V3Controller < ApplicationController
  check_authorization

  rescue_from CanCan::AccessDenied do |exception|
    head 401
  end
end
