class AddLastNameToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :last_name, :string
  end
end
