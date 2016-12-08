class AddStatusToJourney < ActiveRecord::Migration[5.0]
  def change
    add_column :journeys, :status, :string
  end
end
