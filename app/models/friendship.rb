class Friendship < ApplicationRecord
  belongs_to :friend, class_name: 'User'
  belongs_to :user

  scope :pending, -> { where :status => 'pending' }
  scope :requested, -> { where :status => 'requested' }
  scope :confirmed, -> { where :status => 'confirmed' }

  after_create :create_activity
  after_update :create_activity

  scope :between, -> (user, friend) do
    where('(friendships.friend_id =? AND friendships.user_id =?)
      OR (friendships.friend_id =? AND friendships.user_id =?)',
      user.id, friend.id, friend.id, user.id)
  end

  def inflection
    case self.status
    when "pending"
      "sent a request to"
    when "requested"
      "received a friend request from"
    when "confirmed"
      "confirmed friendship with"
    when "rejected"
      "rejected friendship with"
    else ""
    end
  end

  private

  def create_activity
    Activity.create(
      subject: self.friend,
      user: self.user,
      action: self.inflection,
      topic: self.class.to_s,
      path: 'user_profile'
    )
  end

end
