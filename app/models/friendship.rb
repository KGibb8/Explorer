class Friendship < ApplicationRecord
  belongs_to :friend, class_name: 'User'
  belongs_to :user

  scope :pending, -> { where :status => 'pending' }
  scope :confirmed, -> { where :status => 'confirmed' }

  scope :between, -> (user, friend) do
    where('(friendships.friend_id =? AND friendships.user_id =?)
      OR (friendships.friend_id =? AND friendships.user_id =?)',
      user.id, friend.id, friend.id, user.id)
  end
end
