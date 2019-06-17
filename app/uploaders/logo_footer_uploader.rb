# frozen_string_literal: true

# app/uploarder/medium_uploader.rb

class LogoFooterUploader < LogoUploader
  # process :get_dimensions

  before :cache, :get_dimensions # callback, example here: http://goo.gl/9VGHI

  private

  def get_dimensions
    if file && model
      model.footer_width, model.footer_height = ::MiniMagick::Image.open(file.file)[:dimensions]
    end
  end
end
