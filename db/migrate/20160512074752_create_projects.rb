class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.boolean :is_close
      t.date :estimated_start_at
      t.date :estimated_end_at
      t.decimal :estimated_duration
      t.date :real_start_at
      t.date :real_end_at
      t.decimal :real_duration
      t.decimal :difference_hour

      t.timestamps null: false
    end
  end
end
