class AddNameAndDescriptionToExpedition < ActiveRecord::Migration[5.0]
  def change
    add_column :expeditions, :name, :string
    add_column :expeditions, :description, :text
  end
end
