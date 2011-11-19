class AddCoordinatesToRole < ActiveRecord::Migration
  def change
    add_column :roles, :xOffset, :integer
    add_column :roles, :yOffset, :integer
  end
end
