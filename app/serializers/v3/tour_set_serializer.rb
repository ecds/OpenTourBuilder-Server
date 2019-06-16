# frozen_string_literal: true

class V3::TourSetSerializer < ActiveModel::Serializer
  attribute :tenant_admins
  attributes :id, :name, :subdir, :published_tours

  def tenant_admins
    object.admins if current_user.super || current_user.current_tenant_admin?
  end
end
