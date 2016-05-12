class AddFamilyToTask < ActiveRecord::Migration
  def change

    add_column :tasks, :family_id, :integer, references: :families
  end
end
