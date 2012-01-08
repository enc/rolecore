class AddPositionToTask < ActiveRecord::Migration
  def change
    add_column :tasks, :xOffset, :integer
    add_column :tasks, :yOffset, :integer
  end
end
