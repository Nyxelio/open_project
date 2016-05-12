class CreateProjects < ActiveRecord::Migration
  def change
    create_table :projects do |t|
      t.string :name
      t.boolean :is_close
      t.datetime :estimated_start_at
      t.datetime :estimated_end_at
      t.decimal :estimated_duration
      t.datetime :real_start_at
      t.datetime :real_end_at
      t.decimal :real_duration
      t.datetime :difference_hour

      t.timestamps null: false
    end
  end
end
