class CreateWorkers < ActiveRecord::Migration
  def change
    create_table :workers do |t|
      t.string :name
      t.decimal :cost_hour

      t.timestamps null: false
    end
  end
end
