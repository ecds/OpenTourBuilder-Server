# frozen_string_literal: true

# app/models/stop_tag.rb
class StopTag < ApplicationRecord
  validates :title, presence: true
end
