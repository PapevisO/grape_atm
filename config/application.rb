require 'bundler'
Bundler.require :default, ENV['RACK_ENV'] || 'development'

require 'grape'
Dir[__dir__  + '/../app/entities/**/*.rb'].each { |f| require f }
Dir[__dir__  + '/../app/api/**/*.rb'].each { |f| require f }
Dir[__dir__  + '/../app/lib/**/*.rb'].each { |f| require f }
Dir[__dir__  + '/../app/models/**/*.rb'].each { |f| require f }

OTR::ActiveRecord.configure_from_file! File.expand_path('database.yml', __dir__)
