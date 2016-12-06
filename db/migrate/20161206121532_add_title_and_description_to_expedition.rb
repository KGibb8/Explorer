class AddTitleAndDescriptionToExpedition < ActiveRecord::Migration[5.0]
  def change
    add_column :expeditions, :title, :string
    add_column :expeditions, :description, :text
  end
end
