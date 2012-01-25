class AddContextToRelation < ActiveRecord::Migration
  def change
    add_column :relations, :context, :text
  end
end
