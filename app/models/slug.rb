# frozen_string_literal: true

class Slug < ApplicationRecord
  belongs_to :tour
  validates :slug, uniqueness: true
end
