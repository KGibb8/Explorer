class Coordinate < ApplicationRecord
  belongs_to :expedition, required: false

  geocoded_by :location
  after_validation :geocode

end
