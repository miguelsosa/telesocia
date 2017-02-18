source 'https://rubygems.org'


# Specify ruby version so Heroku doesn't complain.
ruby '2.3.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '5.0.0'

# Use Puma as the app server
gem 'puma', '~> 3.0'

# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 3.0.0'

# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.2.1'

# See https://github.com/rails/execjs#readme for more supported runtimes
# gem 'therubyracer', platforms: :ruby

# Use jquery as the JavaScript library
gem 'jquery-rails', '~> 4.1.1'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.5'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', '~> 0.4.0', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

############################################
# Use Devise for user management
gem 'devise'

# Manage bower assetts
gem 'bower-rails'

# Validate Phone numbers
gem 'global_phone', '~> 1.0.1'

# Read environment from .env file
gem 'dotenv-rails'

gem 'rollbar'
gem 'oj', '~> 2.12.14'

# Simple redirection through rack - used to forward from
# www.telesocia.com to heroku until I figure out what todo about ssl
# in heroku for a free app.
gem 'rack-host-redirect'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', '~> 9.0.0', platform: :mri

  # Use jasmine/teaspoon for javascript unit testing
  gem 'teaspoon-jasmine'

  gem 'rspec-rails', '~> 3.5'

  gem "factory_girl_rails"
  gem "faker"

  gem 'guard'
  gem 'guard-rspec'
  gem 'rb-fsevent' # Growl notifications on MacOSX
end

group :development do
  # Access an IRB console on exception pages or by using <%= console %> in views
  gem 'web-console'
end

group :test do
#      gem 'guard'
#      gem 'guard-minitest'
#      gem 'minitest-reporters'
# for rails 5.0 + rspec
  gem 'rails-controller-testing'

  # For end to end acceptace testing
  gem 'poltergeist'
end

group :production do
  # Use postgresql as the database for Active Record
  gem 'pg', '~> 0.15'
  gem 'rails_12factor'
end

