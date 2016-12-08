class AddReferenceToCoordinate < ActiveRecord::Migration[5.0]
  def change
    add_reference :coordinates, :expedition, foreign_key: true
  end
end
