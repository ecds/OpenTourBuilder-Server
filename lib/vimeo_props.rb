class VimeoProps
  include HTTParty
  include Nokogiri
  def initialize(video)
    @video = video
  end

  def id
    if @video.include? 'iframe'
      Nokogiri::HTML(@video).xpath('//iframe')[0]['src'].split('/')[-1]
    else
      /\d{9}/.match(@video)[0]
    end
  end

  def image
    HTTParty.get('https://vimeo.com/api/oembed.json?url=https%3A//vimeo.com/#{self.id}')['thumbnail_url']
  end
end
