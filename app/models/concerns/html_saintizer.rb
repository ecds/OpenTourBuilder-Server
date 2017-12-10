
# frozen_string_literal: true

# app/models/concerns/html_saintizer.rb
module HtmlSaintizer
  extend ActiveSupport::Concern

  def self.accessable(text)
    Rails::Html::FullSanitizer.new.sanitize(text).to_s.gsub(/([A-z]\.)([A-z])/, '\1 \2')
  end

  def self.accessable_truncated(text)
    self.accessable(text).truncate(140)
  end
end
