class AddPathToActivity < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :path, :string
  end
end
