class AddSubjectTypeToActivity < ActiveRecord::Migration[5.0]
  def change
    add_column :activities, :subject_type, :string
  end
end
