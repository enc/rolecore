class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.integer :parent_id
      t.integer :child_role_id
      t.integer :child_task_id

      t.timestamps
    end
  end
end
