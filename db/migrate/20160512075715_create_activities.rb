class CreateActivities < ActiveRecord::Migration
  def change
    create_table :activities do |t|
      t.decimal :num_hours
      t.references :worker, index: true, foreign_key: true
      t.references :task, index: true, foreign_key: true
      t.text :observation
      t.date :date_activity

      t.timestamps null: false
    end
  end
end
