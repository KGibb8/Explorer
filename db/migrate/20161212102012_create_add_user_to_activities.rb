class CreateAddUserToActivities < ActiveRecord::Migration[5.0]
  def change
    create_table :add_user_to_activities do |t|
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
