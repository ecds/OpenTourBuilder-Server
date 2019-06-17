# frozen_string_literal: true

# app/uploarder/medium_uploader.rb

class MediumUploader < CarrierWave::Uploader::Base
  include MiniMagick
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file

  # Override the directory where uploaded files will be stored.
  # def cache_dir
  #   "#{Rails.root}/public/uploads/tmp/#{Rails.env}"
  # end

  def store_dir
    "#{Rails.root}/public/uploads/#{Apartment::Tenant.current}/"
  end

  # Provide a default URL as a default if there hasn't been a file uploaded:
  # def default_url(*args)
  #     # For Rails 3.1+ asset pipeline compatibility:
  #     # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
  #
  #     "/images/fallback/" + [version_name, "default.png"].compact.join('_')
  # end

  # Process files as they are uploaded:
  # process scale: [200, 300]
  #
  # def scale(width, height)
  #     # do something
  # end

  # Create different versions of your uploaded files:
  version :desktop do
    process resize_to_fit: [1500, 1500]
    process :store_desktop_dimensions
  end

  version :tablet, from: :desktop do
    process resize_to_fit: [750, 750]
    process :store_tablet_dimensions
  end

  version :mobile, from: :tablet do
    process resize_to_fit: [300, 300]
    process :store_mobile_dimensions
  end

  version :mobile_list_thumb do
    process resize_to_fill: [200, 200]
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(JPG jpg jpeg gif png)
  end

  def filename
    if model.video.present?
      "#{model.video}.jpg"
    else
      @filename
    end
  end

  private

    def store_desktop_dimensions
      if file && model
        model.desktop_width, model.desktop_height = ::MiniMagick::Image.open(file.file)[:dimensions]
      end
    end

    def store_tablet_dimensions
      if file && model
        model.tablet_width, model.tablet_height = ::MiniMagick::Image.open(file.file)[:dimensions]
      end
    end

    def store_mobile_dimensions
      if file && model
        model.mobile_width, model.mobile_height = ::MiniMagick::Image.open(file.file)[:dimensions]
      end
    end
end
