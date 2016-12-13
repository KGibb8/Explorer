class AddTopicToActivity < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :topic, :string
  end
end
