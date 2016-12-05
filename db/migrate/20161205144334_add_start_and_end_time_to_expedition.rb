class AddStartAndEndTimeToExpedition < ActiveRecord::Migration[5.0]
  def change
    add_column :expeditions, :start_time, :datetime
    add_column :expeditions, :end_time, :datetime
  end
end
