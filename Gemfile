source 'https://rubygems.org'

gem 'rails', '4.2.0'

# GOV.UK styling
gem 'govuk_frontend_toolkit', :git => "https://github.com/alphagov/govuk_frontend_toolkit_gem.git", :submodules => true
gem 'govuk_template'

# rest client gem for handling our api requests
gem 'rest-client'

# Static assets

# Use jquery as the JavaScript library
gem 'jquery-rails'
# Use SCSS for stylesheets
gem 'sass-rails', '~> 5.0'
# Use Uglifier as compressor for JavaScript assets
gem 'uglifier', '>= 1.3.0'
# Use CoffeeScript for .coffee assets and views
gem 'coffee-rails', '~> 4.1.0'
# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
gem 'turbolinks'

#Capitalisation gem, preferrable to rails titleize
#since it handles special cases like "di Caprio" and "McDonalds"
gem 'namecase'

group :development do
  # Debugging
  gem 'byebug'
  gem 'pry'
  gem 'web-console', '~> 2.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  gem 'webmock'
  # Adding SimpleCov to provide coverage of Unit Testing
  gem 'simplecov', :require => false
  # Adding gems to convert unit test coverage and results to be used in Jenkins
  gem 'simplecov-cobertura', '~>1.0.2'
  gem 'rspec-core'
  gem 'rspec_junit_formatter'
  gem 'vcr'
  gem 'minitest-reporters'
  gem 'minitest-ci'
  gem 'poltergeist'
  gem 'rspec'
  gem 'elasticsearch'
end

group :production do
  gem 'therubyracer'
  gem 'rb-readline'
  gem 'unicorn'
  gem 'unicorn-rails'
end
