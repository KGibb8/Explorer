class AddReferencesToJourney < ActiveRecord::Migration[5.0]
  def change
    add_reference :journeys, :user, foreign_key: true
    add_reference :journeys, :expedition, foreign_key: true
  end
end
