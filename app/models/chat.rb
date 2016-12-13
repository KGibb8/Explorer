class Chat < ApplicationRecord
  belongs_to :creator, class_name: 'User'
  belongs_to :expedition
  has_many :messages
end
