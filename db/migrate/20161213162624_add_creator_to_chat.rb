class AddCreatorToChat < ActiveRecord::Migration[5.0]
  def change
    add_reference :chats, :creator, index: true
  end
end
