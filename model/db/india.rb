class India < ActiveRecord::Base
  require "geocoder"
  require "json"
  require "geocoder/railtie"
  Geocoder::Railtie.insert
  extend ::Geocoder::Model::ActiveRecord
  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
  after_save :geocode
end