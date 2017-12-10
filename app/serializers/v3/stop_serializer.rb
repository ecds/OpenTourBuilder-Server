# frozen_string_literal: true

class V3::StopSerializer < ActiveModel::Serializer
  attributes :id, :title, :description, :sanitized_description, :lat, :lng, :metadescription, :article_link, :video_embed, :video_poster, :lat, :lng, :parking_lat, :parking_lng, :direction_intro, :direction_notes
end
