class AddCoordinatesToRole < ActiveRecord::Migration
  def change
    add_column :roles, :xOffset, :integer, :default => 80
    add_column :roles, :yOffset, :integer, :default => 60
  end
end
