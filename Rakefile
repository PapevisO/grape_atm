require 'bundler/setup'
load 'tasks/otr-activerecord.rake'

namespace :db do
  # Some db tasks require app code to be loaded, or at least gems
  task :environment do
    require_relative 'config/application'
  end
end
