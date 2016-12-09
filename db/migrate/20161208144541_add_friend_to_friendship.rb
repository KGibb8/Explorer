class AddFriendToFriendship < ActiveRecord::Migration[5.0]
  def change
    add_reference :friendships, :friend, index: true
  end
end
