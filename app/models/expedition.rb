class Expedition < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  has_many :journeys
  has_many :users, through: :journeys
end
