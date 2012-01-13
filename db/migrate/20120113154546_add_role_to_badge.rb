class AddRoleToBadge < ActiveRecord::Migration
  def change
    add_column :badges, :role_id, :integer
  end
end
