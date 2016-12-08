class CreateExpeditions < ActiveRecord::Migration[5.0]
  def change
    create_table :expeditions do |t|

      t.timestamps
    end
  end
end
