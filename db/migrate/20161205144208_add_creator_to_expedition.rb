class AddCreatorToExpedition < ActiveRecord::Migration[5.0]
  def change
    add_reference :expeditions, :creator, index: true
  end
end
