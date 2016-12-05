class AddBiographyToProfile < ActiveRecord::Migration[5.0]
  def change
    add_column :profiles, :biography, :text
  end
end
