# frozen_string_literal: true

# Model for media associated with stops.
class Medium < ApplicationRecord
  include VideoProps
  before_save :props, if: :video?

  mount_uploader :original_image, MediumUploader
  has_many :stop_media
  has_many :stops, through: :stop_media
  has_many :tour_media
  has_many :tours, through: :tour_media

  # TODO: This ins not ideal, we use these `not_in_*` scopes to make the list of media avaliable to add
  # to a stop or tour. But the paramerter does not make sense when just looking at it. Needs clearer language.
  scope :not_in_stop, lambda { |stop_id| includes(:stop_media).where.not(stop_media: { stop_id: stop_id }) }
  scope :not_in_tour, lambda { |tour_id| includes(:tour_media).where.not(tour_media: { tour_id: tour_id }) }
  scope :no_stops, lambda { includes(:stop_media).where(stop_media: { stop_id: nil }) }
  scope :no_tours, lambda { includes(:tour_media).where(tour_media: { tour_id: nil }) }
  scope :orphan, -> { no_tours.no_stops }
  scope :published_by_tour, lambda { includes(:tours).where(tours: { published: true }) }
  scope :published_by_stop, -> { joins(:stops).merge(Stop.published) }


  def props
    VideoProps.props(self)
  end

  def desktop
    original_image.desktop.url
  end

  def tablet
    original_image.tablet.url
  end

  def mobile
    original_image.mobile_list_thumb.url
  end

  def published
    tours.published.present? || stops { |s| s.tours.published }.present?
  end
end
