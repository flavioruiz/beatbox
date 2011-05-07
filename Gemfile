source "http://rubygems.org"
gem 'rails', '2.3.8'
gem 'rspec'
group :production, :staging do
  gem "pg"
end
group :development, :test do
  gem "sqlite3-ruby", "~> 1.3.0", :require => "sqlite3"
end
