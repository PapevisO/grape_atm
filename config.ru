require 'rack'
require 'rubygems'
require 'bundler/setup'
require 'grape'
require_relative 'config/application'

map '/api/v1' do
  run ATM::API
end

use Rack::Static,
    urls: ['/images', '/lib', '/js', '/css'],
    root: 'public/swagger_ui'

map '/swagger-ui' do
  run lambda { |_env|
    [
      200,
      {
        'Content-Type' => 'txt-html',
        'Cache-Control' => 'public, max-age=86400'
      },
      File.open('public/swagger_ui/index.html', File::RDONLY)
    ]
  }
end
