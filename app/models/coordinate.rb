class Coordinate < ApplicationRecord
  belongs_to :expedition, required: false
end
