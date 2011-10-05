class CreateRelationProperties < ActiveRecord::Migration
  def change
    create_table :relation_properties do |t|
      t.integer :relation_id

      t.timestamps
    end
  end
end
