class CreateFamilies < ActiveRecord::Migration
  def change
    create_table :families do |t|
      t.string :label

      t.timestamps null: false
    end
  end
end
