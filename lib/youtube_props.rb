class YouTubeProps
  include YouTubeRails
  include Yt

  def initialize(video)
    @video = video
  end

  def id
    YouTubeRails.extract_video_id(@video)
  end

  def image
    Yt::Video.new(id:id).thumbnail_url('standard')
  end
end
