# frozen_string_literal: true

source 'https://rubygems.org'

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?('/')
  "https://github.com/#{repo_name}.git"
end


# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.0'
gem "rack", ">= 2.0.6"
gem 'pg'
# Multitenancy for Rails and ActiveRecord
gem 'apartment'
# For JSONAPI responses
gem 'active_model_serializers', '~> 0.10.0.rc3'
gem 'acts-as-taggable-on', '~> 5.0'
# Use Puma as the app server
gem 'puma', '~> 3.7'
# Use Redis adapter to run Action Cable in production
gem 'redis', '~> 3.0'
gem "actionview", ">= 5.2.2.1"
# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Social Auth
# gem 'ecds_rails_auth_engine', path: '../ecds_auth_engine'
gem 'ecds_rails_auth_engine', git: 'https://github.com/ecds/ecds_rails_auth_engine.git', :tag => 'v0.1.5'
gem 'cancancan', '~> 2.0'

# Active Storage will land in 5.2
gem 'carrierwave', '~> 1.0'
gem 'mini_magick'

# Vidoe provider APIs
gem 'vimeo'
gem 'yt'
gem 'youtube_rails'

# Use Rack CORS for handling Cross-Origin Resource Sharing (CORS), making cross-origin AJAX possible
gem 'rack-cors'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  # gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
  gem "test-prof"
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'rspec-rails', '~> 3.5'
  # Use Capistrano for deployment
  gem 'capistrano-rails'
  gem 'capistrano-rbenv', '~> 2.0'
  gem 'capistrano-passenger'
end
  
  gem "factory_bot"

group :test do
  gem 'factory_bot_rails'
  gem 'shoulda-matchers', git: 'https://github.com/thoughtbot/shoulda-matchers.git', branch: 'rails-5'
  gem 'faker', git: 'https://github.com/stympy/faker.git', branch: 'master'
  gem 'database_cleaner'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
