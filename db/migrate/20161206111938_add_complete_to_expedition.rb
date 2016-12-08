class AddCompleteToExpedition < ActiveRecord::Migration[5.0]
  def change
    add_column :expeditions, :complete, :boolean
  end
end
