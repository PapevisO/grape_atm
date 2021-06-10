require 'bundler'
require 'rubygems'
require 'grape'

RACK_ENV = (ENV['RACK_ENV'] || 'development').to_sym
Bundler.require

%w[entries lib models].each do |nested|
  Dir[__dir__ + "/../app/#{nested}/**/*.rb"].each do |path|
    puts "path to require: #{path}"
    require path
  end
end
require_relative(__dir__ + '/../app/api/atm.rb')

OTR::ActiveRecord.configure_from_file! File.expand_path('database.yml', __dir__)
