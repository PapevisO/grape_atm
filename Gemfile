source 'https://rubygems.org'

ruby '2.6.6'

gem 'grape'
gem 'grape-entity'
gem 'grape-swagger', '~> 1.4'
gem 'mysql2'
gem 'otr-activerecord'
gem 'rack-fiber_pool'

group :development do
  gem 'rubocop', require: false
end

group :development, :test do
  gem 'awesome_print'
  gem 'byebug'
  gem 'pry'
  gem 'pry-byebug', '~> 3.8'
end

group :test do
  gem 'database_cleaner'
  gem 'rack'
  gem 'rack-test'
  gem 'rspec'
  gem 'shoulda-matchers'
end
