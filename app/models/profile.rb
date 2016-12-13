require './app/uploaders/avatar_uploader'

class Profile < ApplicationRecord
  belongs_to :user, dependent: :delete

  mount_uploader :avatar, AvatarUploader

  def full_name
    "#{first_name} #{last_name}"
  end

end
