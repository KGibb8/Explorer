class AddLocationBooleanToCoordinate < ActiveRecord::Migration[5.0]
  def change
    add_column :coordinates, :start_location, :boolean
    add_column :coordinates, :end_location, :boolean
  end
end
