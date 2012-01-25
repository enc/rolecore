source 'http://rubygems.org'

gem 'rails', '3.2.0'

# Bundle edge Rails instead:
# gem 'rails',     :git => 'git://github.com/rails/rails.git'

# gem 'sqlite3'
gem 'mysql2'
gem 'haml-rails'
gem 'twitter-bootstrap-rails'
gem 'simple_form'


# Gems used only for assets and not required
# in production environments by default.
group :assets do
  gem 'sass-rails', "  ~> 3.2.3"
  gem 'coffee-rails', "~> 3.2.1"
  gem 'uglifier', '>= 1.0.3'
end

group :develoment do
  gem 'pry-rails'
  gem 'rails3-generators'
end

gem 'jquery-rails'

# Use unicorn as the web server
# gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano'

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :test, :development do
  gem 'rspec-rails'
  gem 'launchy'
  # gem 'capybara-webkit'
  gem 'rb-fsevent'
end
group :test do
  # Pretty printed test output
  gem 'pry'
  gem 'turn', :require => false
  gem 'capybara'
  gem 'guard-rspec'
  gem 'factory_girl_rails'
  gem 'spork', "> 0.9.0.rc"
  gem 'guard-spork'
  # gem 'growl'
end
