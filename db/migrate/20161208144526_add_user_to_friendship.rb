class AddUserToFriendship < ActiveRecord::Migration[5.0]
  def change
    add_reference :friendships, :user, foreign_key: true
  end
end
