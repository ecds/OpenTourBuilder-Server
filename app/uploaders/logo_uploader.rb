# frozen_string_literal: true

# app/uploarder/medium_uploader.rb

class LogoUploader < CarrierWave::Uploader::Base
  include MiniMagick
  # include CarrierWave::RMagick
  include CarrierWave::MiniMagick

  # Choose what kind of storage to use for this uploader:
  storage :file

  process resize_to_limit: [1000, 80]

  def store_dir
    "#{Rails.root}/public/uploads/#{Apartment::Tenant.current}/"
  end

  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
  def extension_whitelist
    %w(JPG jpg jpeg gif png)
  end
end
