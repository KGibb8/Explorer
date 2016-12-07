class AddLatitudeAndLongitudeToExpedition < ActiveRecord::Migration[5.0]
  def change
    add_column :expeditions, :start_lat, :float
    add_column :expeditions, :start_lng, :float
    add_column :expeditions, :end_lat, :float
    add_column :expeditions, :end_lng, :float
  end
end
