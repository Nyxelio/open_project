class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.string :firstname
      t.string :lastname
      t.decimal :cost_hour

      t.timestamps null: false
    end
  end
end
