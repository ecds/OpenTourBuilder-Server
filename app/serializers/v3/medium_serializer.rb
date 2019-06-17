# frozen_string_literal: true

class V3::MediumSerializer < ActiveModel::Serializer
  attributes :id, :title, :caption, :desktop, :tablet, :mobile, :video, :provider, :original_image, :embed, :srcset, :srcset_sizes, :insecure
end
