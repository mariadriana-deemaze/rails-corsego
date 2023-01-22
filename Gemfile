source "https://rubygems.org"
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby "3.1.2"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails", "~> 7.0.4"

# The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
gem "sprockets-rails"

# Use postgresql as the database for Active Record
gem "pg", "~> 1.1"

# Use the Puma web server [https://github.com/puma/puma]
gem "puma", "~> 5.0"

# Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
gem "importmap-rails"

# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"

# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Haml dependencies
gem 'haml'
gem 'html2haml'
gem "haml-rails", "~> 2.0"

# Dummy data
gem 'faker'

# Use Sass to process CSS
gem "sassc-rails"

# hot reload
gem "rails_live_reload"

# Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
gem "image_processing", "~> 1.2"

# Use simpler forms
gem 'simple_form'

# Use auth
gem "devise"

# Use friendly id's for whatever we might want
gem 'friendly_id', '~> 5.4.0'

gem "tailwindcss-rails", "~> 2.0"

# filtering 
gem "ransack"

# track user activities
gem "public_activity"

# user roles
gem "rolify"

# user roles access policies
gem "pundit", "~> 2.3"

# pagination
gem 'pagy', '~> 3.5'

# charts
gem "chartkick"

# agreggate data utils
gem "groupdate"

# record sorting lib
gem 'ranked-model'

#validate image and file uploads
gem 'active_storage_validations'

#PDF gen
gem 'wicked_pdf'
gem 'wkhtmltopdf-binary'

# alert production exception
gem 'exception_notification'

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[ mri mingw x64_mingw ]
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'factory_bot_rails', require: false
end

group :development do
  # save mailers previews
  gem "letter_opener"
  
  # visualize your schema relationships
  gem 'rails-erd'
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"
end

group :test do
  # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
  gem "capybara"
  gem "selenium-webdriver"
  gem "webdrivers"
end


