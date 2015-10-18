require 'rubygems'
require 'bundler'

Bundler.require

require './lib/api_config'
require './lib/api_request'
require './lib/api_response'
require './lib/fyber_api'
require './lib/app'

run App
