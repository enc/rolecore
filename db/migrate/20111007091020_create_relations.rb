class CreateRelations < ActiveRecord::Migration
  def change
    create_table :relations do |t|
      t.integer :parent_id
      t.integer :child_id
      t.string :child_type

      t.timestamps
    end
  end
end
