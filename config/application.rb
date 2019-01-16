require 'bundler'
Bundler.require :default, ENV['RACK_ENV'] || 'development'

require 'grape'
Dir[__dir__  + '/../app/entities/**/*.rb'].each { |f| require f }
Dir[__dir__  + '/../app/lib/**/*.rb'].each { |f| require f }
Dir[__dir__  + '/../app/models/**/*.rb'].each { |f| require f }
require_relative '../app/api/v1/api'

OTR::ActiveRecord.configure_from_file! File.expand_path('database.yml', __dir__)
