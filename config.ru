require "geocoder"
require "json"
require "geocoder/railtie"
Geocoder::Railtie.insert
require_relative './app'


# run App
run Sinatra::Application