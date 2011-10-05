class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :task_id
      t.string :name
      t.boolean :sod
      t.integer :weight

      t.timestamps
    end
  end
end
