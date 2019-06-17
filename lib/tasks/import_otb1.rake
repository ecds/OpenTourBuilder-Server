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

    # Create New TourSet
    p "Createing #{options[:set]}"
    tour_set = TourSet.create(name: options[:set])

    p "Switching to #{tour_set.subdir}"
    # Switch to TourSet
    Apartment::Tenant.switch! tour_set.subdir

    p "Current tenant: #{Apartment::Tenant.current}"

    # Create the Modes
    # p 'Creating Modes'
    # d.select { |d1| d1['model'] === 'tour.directionsmode' }.each do |mode|
    #   p mode['fields']['mode']
    #   Mode.find_or_create_by(title: mode['fields']['mode'])
    # end

    # create the themes
    Theme.create(title: 'default')
    Theme.create(title: 'dark')
    Theme.create(title: 'blu')

    # Create Tours
    p 'Creating tours'
    tour = nil
    d.select { |d1| d1['model'] === 'tour.tour' }.each do |t|
      p t['fields']['name']
      tour = Tour.new
      tour.title = t['fields']['name']
      tour.description = t['fields']['description']
      tour.meta_description = t['fields']['metadescription']
      tour.published = t['fields']['published']
      tour.is_geo = t['fields']['is_geo'] || true
      tour.theme = Theme.first

      # modes = []
      # t['fields']['modes'].each do |mode|
      #   mpk = (d.find { |d1| d1['model'] === 'tour.directionsmode' && d1['pk'] === mode })
      #   modes.push(Mode.find(mpk['pk']))
      # end

      # tour.modes = modes

      # tour.mode = Mode.where(title: d.select { |d1| d1['model'] === 'tour.directionsmode' }.find { |mode| mode['fields']['mode'] === t['fields']['default_mode'] }['fields']['mode']).first
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
        v3_stop.description = ['fields']['description']
        v3_stop.lat = ['fields']['lat']
        v3_stop.lng = ['fields']['lng']
        # stop.address
        v3_stop.metadescription = ['fields']['metadescription']
        v3_stop.article_link = ['fields']['article_link']
        v3_stop.parking_lat = ['fields']['park_lat']
        v3_stop.parking_lng = ['fields']['park_lng']
        v3_stop.direction_intro = ['fields']['directions_intro']
        v3_stop.direction_notes = ['fields']['directions_notes']
        stop.tours = [tour]
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
      flat.tours = [tour]
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
          p "http://api-campustour.ecdsweb.org/media/#{m['fields']['image']}"
          if m['fields']['tour_stop'] == intro_id
            medium = Medium.new
            medium.title = m['fields']['title']
            medium.caption = m['fields']['caption']
            medium.remote_original_image_url = "http://api-campustour.ecdsweb.org/media/#{m['fields']['image']}"
            medium.tours = [tour]
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
      p "http://api-campustour.ecdsweb.org/media/#{m['fields']['image']}"
      medium = Medium.new
      medium.title = m['fields']['title']
      medium.caption = m['fields']['caption']
      medium.remote_original_image_url = "http://api-campustour.ecdsweb.org/media/#{m['fields']['image']}"
      medium.stops = [Stop.where(title: d.select { |d1| d1['model'] === 'tour.tourstop' && d1['pk'] === m['fields']['tour_stop'] }.first['fields']['name']).first]
      medium.save
    end

    # Set Stop Medium Position
    p 'Setting stop medium position'
    d.select { |d1| d1['model'] === 'tour.tourstopmedia' }.each do |m|
      p m['fields']['title']
      medium = Medium.where(title: m['fields']['title']).first
      stop = medium.stops.first
      stop_medium = StopMedium.where(medium_id: medium.id).where(stop_id: stop.id).first
      stop_medium.position = m['fields']['position']
      stop_medium.save
    end
    p 'DONE!!!!'
  end

  task import_jsonapi: :environment do
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

    # Create New TourSet
    p "Createing #{options[:set]}"
    tour_set = TourSet.find_or_create_by(name: options[:set])

    p "Switching to #{tour_set.subdir}"
    # Switch to TourSet
    Apartment::Tenant.switch! tour_set.subdir

    p "Current tenant: #{Apartment::Tenant.current}"

    # Create Tours
    p 'Creating tours'
    p d['data']['attributes']['title']
    tour = Tour.new
    tour.title = d['data']['attributes']['title']
    tour.description = d['data']['attributes']['description']
    tour.meta_description = d['data']['attributes']['metadescription']
    tour.published = d['data']['attributes']['published']
    tour.is_geo = d['data']['attributes']['is_geo'] || true
    tour.theme = Theme.first
    tour.save

    # Create the Stops
    p 'Creating stops'
    d['included'].select { |d1| d1['type'] === 'stops' }.each do |s|
      p s['attributes']['title']
      stop = Stop.new
      stop.title = s['attributes']['title']
      stop.description = s['attributes']['description']
      stop.lat = s['attributes']['lat']
      stop.lng = s['attributes']['lng']
      stop.metadescription = s['attributes']['metadescription']
      stop.article_link = s['attributes']['article_link']
      stop.parking_lat = s['attributes']['park_lat']
      stop.parking_lng = s['attributes']['park_lng']
      stop.direction_intro = s['attributes']['directions_intro']
      stop.direction_notes = s['attributes']['directions_notes']
      stop.tours << tour
      stop.save
    end

    # Create the Flat Pages
    p 'Creating flat pages'
    d.select { |d1| d1['type'] === 'flat_pages' }.each do |f|
      p f['attributes']['title']
      flat = FlatPage.new
      flat.title = f['attributes']['title']
      flat.content = f['attributes']['description']
      flat.tours = [Tour.find(f['attributes']['tour'])]
      flat.save
    end

    # Create Media
    p 'Creating Media'
    d['included'].select { |d1| d1['type'] === 'media' }.each do |m|
      medium = Medium.new
      medium.title = m['attributes']['title']
      medium.caption = m['attributes']['caption']
      medium.remote_original_image_url = "https://otp-api.ecdsdev.org#{m['attributes']['original_image']['ulr']}"
      medium.save
    end
    p 'DONE!!!!'
  end

  task fix_stops: :environment do
    options = {
      dump: nil,
      set: nil,
      media: nil
    }

    opts = OptionParser.new
    opts.banner = 'Usage: rake add [options]'
    opts.on('-d DUMP', '--dump DUMP') { |dump| options[:dump] = dump }
    opts.on('-s SET', '--set SET') { |set| options[:set] = set }
    opts.on('-m MEDIA', '--media MEDIA') { |media| options[:media] = media }

    args = opts.order!(ARGV) {}

    opts.parse!(args)

    p options[:dump]

    file = File.read(options[:dump])
    d = JSON.parse(file)

    # Create New TourSet
    p "Createing #{options[:set]}"
    tour_set = TourSet.find_or_create_by(name: options[:set])

    p "Switching to #{tour_set.subdir}"
    # Switch to TourSet
    Apartment::Tenant.switch! tour_set.subdir

    p "Current tenant: #{Apartment::Tenant.current}"

    d.select { |stops| stops['model'] === 'tour.tourstop' }.each do |v2_stop|
      next if v2_stop['fields']['position'] == 0
      v3_stop = Stop.find_by(title: v2_stop['fields']['name'])
      v2_tour = d.select { |t| t['model'] === 'tour.tour' && t['pk'] === v2_stop['fields']['tour'] }.first
      v3_tour = Tour.find_by(title: v2_tour['fields']['name'])
      v3_stop.tours = [v3_tour]
      v3_stop.tour_stops.first.position = v2_stop['fields']['position']
      v3_stop.tour_stops.first.save
      v3_tour.save
      v3_stop.save

      # Stop Media
      d.select { |m| m['model'] === 'tour.tourstopmedia' && m['fields']['tour_stop'] == v2_stop['pk'] }.each do |v2_medium|
        v3_medium = Medium.new
        v3_medium.title = v2_medium['fields']['title']
        v3_medium.caption = v2_medium['fields']['caption']
        v3_medium.embed = "#{v2_medium['fields']['metadata']} ||| #{v2_medium['fields']['source_link']}"
        p "Fetching #{options[:media]}/media/#{v2_medium['fields']['image']}"
        v3_medium.remote_original_image_url = "#{options[:media]}/media/#{v2_medium['fields']['image']}"
        v3_medium.save
        v3_stop.media << v3_medium
      end
    end
  end
end

# media.each do |m|
#   attrs = m['attributes']
#   if attrs['video'].length == 0
#     medium = Medium.find_by(caption: attrs['caption'])
#     p 'found one'
#     medium.remote_original_image_url = "https://otb-api.ecdsdev.org#{attrs['original_image']['url']}"
#     medium.save
#   end
# end; nil

# require 'google/apis/sheets_v4'
# service = Google::Apis::SheetsV4::SheetsService.new
# spreadsheet_id = '1b1J0Gt9NPLsrfXJ-agc2GjCRb-7Upq7w1ddW40dV4i4'
# response = service.get_spreadsheet(spreadsheet_id, ranges: 'A2:E', include_grid_data: true)
# sheet = response.sheets[0]

# def format_column(column)
#   start_indicies = []
#   parts = []
#   italic_parts = []
#   # start indicies for each part
#   column.text_format_runs.each_with_index do |tr, index|
#     start_indicies.push(tr.start_index.to_i)
#     if tr.format.italic?
#       italic_parts.push(index)
#     end
#   end

#   start_indicies.each_with_index do |start, index|
#     last = index != start_indicies.length - 1 ? start_indicies[index + 1] : column.formatted_value.length
#     parts.push(column.formatted_value[start...last])
#   end

#   italic_parts.each do |part|
#     parts[part] = "<i>#{parts[part]}</i>"
#   end

#   parts.join
# end

# #
# # each row
# # sheet.data[0].row_data[65].values[2].text_format_runs.each do |tr|
# sheet.data[0].row_data.each do |row_data|
#   row_data.values.each do |column|
#     if column.text_format_runs
#       p format_column(column)
#     else
#       p column.formatted_value
#     end
#   end
# end
