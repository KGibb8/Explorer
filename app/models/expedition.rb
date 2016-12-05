class Expedition < ApplicationRecord
  belongs_to :creator, class_name: 'User'

  has_many :journeys
  has_many :invited_users, lambda { where journeys: { :status => 'invited'  }  }, through: :journeys, source: :user
  has_many :attending_users, lambda { where journeys: { :status => 'attending'  }  }, through: :journeys, source: :user
end
