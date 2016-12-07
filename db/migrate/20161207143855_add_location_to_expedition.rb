class AddLocationToExpedition < ActiveRecord::Migration[5.0]
  def change
    add_column :expeditions, :location, :string
  end
end
