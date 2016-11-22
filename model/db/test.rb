class Test < ActiveRecord::Base
  require "geocoder"
  require "json"
  require "geocoder/railtie"
  geocoded_by :address
  after_validation :geocode, if: ->(obj){ obj.address.present? and obj.address_changed? }
end