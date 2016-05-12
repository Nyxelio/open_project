class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :code
      t.string :label
      t.datetime :estimated_start_at
      t.datetime :estimated_end_at
      t.decimal :estimated_duration
      t.datetime :real_start_at
      t.datetime :real_end_at
      t.decimal :real_duration
      t.decimal :percent_progress
      t.decimal :ratio
      t.references :project, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end
