class Coordinate < ApplicationRecord
  belongs_to :expedition, required: false

  geocoded_by :location
  reverse_geocoded_by :latitude, :longitude, :address => :location

  before_create :geocode
  before_update :reverse_geocode

end
