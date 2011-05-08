source "http://rubygems.org"
gem 'rails', '2.3.8'
gem 'json'
gem 'authlogic', '2.1.6'
gem 'httparty'

group :production, :staging do
  gem "pg"
end

group :development, :test do
  gem "sqlite3-ruby", "~> 1.3.0", :require => "sqlite3"
  gem 'rspec'
  gem 'factory_girl'
  gem 'rspec-rails-w-factory_girl'
end
