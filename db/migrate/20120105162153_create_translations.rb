class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations do |t|
      t.string :text
      t.string :lang
      t.integer :message_id

      t.timestamps
    end
  end
end
