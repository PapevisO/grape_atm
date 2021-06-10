require 'rack'
require 'rubygems'
require 'bundler/setup'
require 'grape'
require_relative 'config/application'

run ATM::API
