# frozen_string_literal: true
require 'faker'

module VideoProps
  extend ActiveSupport::Concern

  def self.props(medium)
    return if medium.video.nil?
    if self.is_vimeo(medium)
      medium.provider = 'vimeo'
      medium.video = vimeo_id(medium)
      metadata = HTTParty.get("https://vimeo.com/api/oembed.json?url=https%3A//vimeo.com/video/#{medium.video}")
      medium.title = metadata['title']
      medium.caption = metadata['description']
      image = metadata['thumbnail_url']
      medium.remote_original_image_url = vimeo_image(medium)
      medium.embed = "<iframe title='#{metadata['title']}' src='https://player.vimeo.com/video/#{medium.video}' frameborder='0' webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>"

    elsif self.is_youtube(medium)
      medium.provider = 'youtube'
      medium.video = youtube_id(medium)
      Yt.configuration.api_key = 'AIzaSyCjSl_aNiDsWnNNdS6iSJ5JVklP1vmtcek'
      metadata = Yt::Video.new(id: medium.video)
      medium.remote_original_image_url = "https://img.youtube.com/vi/#{medium.video}/0.jpg"
      begin
        medium.title = metadata.title
        medium.caption = metadata.description
        medium.embed = %Q[<iframe title="#{metadata.title}" src='https://www.youtube.com/embed/#{medium.video}' frameborder='0' allowfullscreen>]
      rescue Yt::Errors::NoItems
        medium.provider = nil
        medium.video = nil
      end
    end
  end

  # def set_embed(medium)
  #   if medium.provider == 'youtube'
  #     medium.embed = "<iframe src='https://www.youtube.com/embed/#{medium.video}' frameborder='0' allowfullscreen>"
  #   elsif medium.provider == 'vimeo'
  #     medium.embed = "<iframe src='https://player.vimeo.com/video/#{medium.video}' frameborder='0' webkitAllowFullScreen mozallowfullscreen allowFullScreen></iframe>"
  #   end
  #   medium.save
  # end

  # <iframe title="Biological PPE: Ebola Virus Disease - PAPR Level - Doffing src=" https:="" www.youtube.com="" embed="" 8kwjszjrvg4'="" frameborder="0" allowfullscreen=""></iframe>


  def self.is_youtube(medium)
    # FIXME Youtube is always going to return 200
    (medium.video.include? 'youtube.com') || (medium.video.include? 'youtu.be') || (!medium.video.include?('iframe') && HTTParty.get("https://www.youtube.com/watch?v=#{medium.video}").code == 200)
  end

  def self.is_vimeo(medium)
    (medium.video.include? 'vimeo') || (!medium.video.include?('iframe') && HTTParty.get("https://vimeo.com/#{medium.video}").code == 200)
  end

  def self.youtube_id(medium)
    if medium.video.include? 'iframe'
      YouTubeRails.extract_video_id(Nokogiri::HTML(medium.video).xpath('//iframe')[0]['src'])
    elsif medium.video.include?('youtu')
      YouTubeRails.extract_video_id(medium.video)
    else
      medium.video
    end
  end

  def self.vimeo_id(medium)
    if medium.video.include? 'iframe'
      Nokogiri::HTML(medium.video).xpath('//iframe')[0]['src'].split('/')[-1]
    else
      /\d{7,10}/.match(medium.video)[0]
      # /https?:\/\/{?:www\.}?vimeo.com\/{?:channels\/(?:\w+\/)?|groups\/([^/]*)\/videos\/|album\/(\d+)\/video\/|)(\d+)(?:$|\/|\?)/.match(medium.video)[0]
    end
  end

  def self.vimeo_image(medium)
    data = HTTParty.get("https://vimeo.com/api/oembed.json?url=https%3A//vimeo.com/#{medium.video}")
    if data['thumbnail_url']
      return data['thumbnail_url'].gsub(/\d\d\dx\d\d\d/, '640x480')
    end
    Faker::Placeholdit.image('640x480')
  end
end
