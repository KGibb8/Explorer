class AddHeaderToExpedition < ActiveRecord::Migration[5.0]
  def change
    add_column :expeditions, :header, :string
  end
end
