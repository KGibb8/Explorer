class AddFbImageToUser < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :fb_profile, :string
  end
end
