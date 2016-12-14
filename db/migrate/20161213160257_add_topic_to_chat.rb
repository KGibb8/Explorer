class AddTopicToChat < ActiveRecord::Migration[5.0]
  def change
    add_column :chats, :topic, :string
  end
end
