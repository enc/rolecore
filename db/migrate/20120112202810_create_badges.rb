class CreateBadges < ActiveRecord::Migration
  def change
    create_table :badges do |t|
      t.integer :score
      t.integer :message_id

      t.timestamps
    end
  end
end
