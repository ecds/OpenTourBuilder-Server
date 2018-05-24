
# frozen_string_literal: true

namespace :ImportOTB1 do
  require 'json'
  require 'optparse'

  desc 'Import JSON dump from OpenTourBuilder v1'
  task import: :environment do
    options = {
      dump: nil,
      set: nil
    }

    opts = OptionParser.new
    opts.banner = 'Usage: rake add [options]'
    opts.on('-d DUMP', '--dump DUMP') { |dump| options[:dump] = dump }
    opts.on('-s SET', '--set SET') { |set| options[:set] = set }

    args = opts.order!(ARGV) {}

    opts.parse!(args)

    p options[:dump]

    file = File.read(options[:dump])
    d = JSON.parse(file)

    # Tour Stop
    # d.select {|d1| d1['model']==='tour.tourstop' && d1['pk']===4}
    # d.select {|d1| d1['model']==='tour.tourstop'}.each do |s|
    #   p s['fields']['name']
    # end

    # t = d.select {|d1| d1['model']==='tour.directionsmode'}.find{ |mode| mode['fields']['mode']==='TRANSIT'}

    # Create New TourSet
    p "Createing #{options[:set]}"
    tour_set = TourSet.create(name: options[:set])

    # Switch to TourSet
    Apartment::Tenant.switch! tour_set.subdomain

    # Create the Modes
    p "Creating Modes"
    d.select { |d1| d1['model'] === 'tour.directionsmode' }.each do |mode|
      p mode['fields']['mode']
      Mode.create(title: mode['fields']['mode'])
    end

    # create the themes
    Theme.create(title: 'default')
    Theme.create(title: 'dark')
    Theme.create(title: 'blu')

    # Create Tours
    p 'Creating tours'
    d.select { |d1| d1['model'] === 'tour.tour' }.each do |t|
      p t['fields']['name']
      tour = Tour.new
      tour.title = t['fields']['name']
      tour.description = t['fields']['description']
      tour.meta_description = t['fields']['metadescription']
      tour.published = t['fields']['published']
      tour.is_geo = t['fields']['is_geo'] || true
      tour.theme = Theme.first

      modes = []
      t['fields']['modes'].each do |mode|
        mpk = (d.find { |d1| d1['model'] === 'tour.directionsmode' && d1['pk'] === mode })
        modes.push(Mode.find(mpk['pk']))
      end

      tour.modes = modes

      tour.mode = Mode.where(title: d.select { |d1| d1['model'] === 'tour.directionsmode' }.find { |mode| mode['fields']['mode'] === t['fields']['default_mode'] }['fields']['mode']).first
      tour.save
    end

    # Create the Stops
    p 'Creating stops'
    d.select { |d1| d1['model'] === 'tour.tourstop' }.each do |s|
      if s['fields']['position'] == 0
        p "#{s['fields']['name']} is inro stop"
        tour = Tour.where(title: d.select { |d1| d1['model'] === 'tour.tour' && d1['pk'] === s['fields']['tour'] }.first['fields']['name']).first
        tour.description = s['fields']['description']
        tour.article_link = s['fields']['article_link']
        tour.save

        if !s['fields']['embed'].nil?
          medium = Medium.create(video: s['fields']['embed'], tours: [tour])
        end

      else
        p s['fields']['name']
        stop = Stop.new
        stop.title = s['fields']['name']
        stop.description = s['fields']['description']
        stop.lat = s['fields']['lat']
        stop.lng = s['fields']['lng']
        # stop.address
        stop.metadescription = s['fields']['metadescription']
        stop.article_link = s['fields']['article_link']
        stop.parking_lat = s['fields']['park_lat']
        stop.parking_lng = s['fields']['park_lng']
        stop.direction_intro = s['fields']['directions_intro']
        stop.direction_notes = s['fields']['directions_notes']
        stop.tours = [Tour.find(s['fields']['tour'])]
        stop.save

        if s['fields']['video_embed']
          medium = Medium.new
          medium.video = s['fields']['video_embed']
          medium.stops = [stop]
          medium.save
        end
      end
    end

    # Set Stop Position
    p 'Setting stop positions'
    d.select { |d1| d1['model'] === 'tour.tourstop' }.each do |s|
      if s['fields']['position'] != 0
        stop = Stop.where(title: s['fields']['name']).first
        tour = stop.tours.first
        tour_stop = TourStop.where(stop_id: stop.id).where(tour_id: tour.id).first
        tour_stop.position = s['fields']['position']
        tour_stop.save
      end
    end

    # Create the Flat Pages
    p 'Creating flat pages'
    d.select { |d1| d1['model'] === 'tour.tourinfo' }.each do |f|
      p f['fields']['name']
      flat = FlatPage.new
      flat.title = f['fields']['name']
      flat.content = f['fields']['description']
      flat.tours = [Tour.find(f['fields']['tour'])]
      flat.save
    end

    # Set Flat Page Position
    d.select { |d1| d1['model'] === 'tour.tourinfo' }.each do |f|
      flat_page = FlatPage.where(title: f['fields']['name']).first
      tour = flat_page.tours.first
      tour_flat_page = TourFlatPage.where(flat_page_id: flat_page.id).where(tour_id: tour.id).first
      tour_flat_page.position = f['fields']['position']
      tour_flat_page.save
    end

    # Create Tour Media
    p 'Creating tour media'
    d.select { |d1| d1['model'] === 'tour.tourstop' }.each do |s|
      if s['fields']['position'] == 0
        intro_id = s['pk']
        tour_id = s['fields']['tour']

        d.select { |d1| d1['model'] === 'tour.tourstopmedia' && d1['fields']['tour_stop'] == intro_id }.each do |m|
          p "https://battleofatlanta.digitalscholarship.emory.edu/media/#{m['fields']['image']}"
          if m['fields']['tour_stop'] == intro_id
            medium = Medium.new
            medium.title = m['fields']['title']
            medium.caption = m['fields']['caption']
            medium.remote_original_image_url = "https://battleofatlanta.digitalscholarship.emory.edu/media/#{m['fields']['image']}"
            medium.tours = [Tour.find(tour_id)]
            medium.save
            d.delete(m)
          end
        end
      end
    end

    # Set Tour Medium Position
    p 'Seting tour media position'
    d.select { |d1| d1['model'] === 'tour.tourtourmedia' }.each do |m|
      medium = Medium.where(title: m['fields']['title']).first
      tour = medium.tours.first
      tour_medium = TourMedium.where(medium_id: medium.id).where(tour_id: tour.id).first
      tour_medium.position = m['fields']['position']
      tour_medium.save
    end

    d.delete(d.select { |d1| d1['model'] === 'tour.tourstop' && d1['fields']['position'] === 0 }.first)

    # Create Stop Media
    p 'Creating stop media'
    d.select { |d1| d1['model'] === 'tour.tourstopmedia' }.each do |m|
      p "https://battleofatlanta.digitalscholarship.emory.edu/media/#{m['fields']['image']}"
      medium = Medium.new
      medium.title = m['fields']['title']
      medium.caption = m['fields']['caption']
      medium.remote_original_image_url = "https://battleofatlanta.digitalscholarship.emory.edu/media/#{m['fields']['image']}"
      medium.stops = [Stop.where(title: d.select { |d1| d1['model'] === 'tour.tourstop' && d1['pk'] === m['fields']['tour_stop'] }.first['fields']['name']).first]
      medium.save
    end

    # Set Stop Medium Position
    p 'Setting stop medium position'
    d.select { |d1| d1['model'] === 'tour.tourstopmedia' }.each do |m|
      medium = Medium.where(title: m['fields']['title']).first
      stop = medium.stops.first
      stop_medium = StopMedium.where(medium_id: medium.id).where(stop_id: stop.id).first
      stop_medium.position = m['fields']['position']
      stop_medium.save
    end
    p 'DONE!!!!'
  end
end
