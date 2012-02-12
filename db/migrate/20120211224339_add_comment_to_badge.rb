class AddCommentToBadge < ActiveRecord::Migration
  def change
    add_column :badges, :comment, :string

  end
end
