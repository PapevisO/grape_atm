require 'bundler'
Bundler.require :default, ENV['RACK_ENV'] || 'development'

require_relative '../app/api/v1/api'
require_relative '../app/lib/setupable'
require_relative '../app/models/payload'

OTR::ActiveRecord.configure_from_file! File.expand_path('database.yml', __dir__)
