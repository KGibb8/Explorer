class Activity < ApplicationRecord
  belongs_to :subject, polymorphic: true
  belongs_to :user

  scope :involving, ->(user) { where('user_id =?', user.id) }

end
