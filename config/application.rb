require 'bundler'
require 'rubygems'
require 'grape'

RACK_ENV = (ENV['RACK_ENV'] || 'development').to_sym
Bundler.require

# sequence of folders to load matters
Dir[__dir__ + '/initializers/*.rb'].each do |path|
  require path
end

%w[lib models entities api].each do |nested|
  Dir[__dir__ + "/../app/#{nested}/**/*.rb"].each do |path|
    require path
  end
end

OTR::ActiveRecord.configure_from_file! File.expand_path('database.yml', __dir__)
