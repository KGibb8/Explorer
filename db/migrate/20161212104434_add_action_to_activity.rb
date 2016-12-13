class AddActionToActivity < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :action, :string
  end
end
