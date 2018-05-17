class RemoveItemGroupIdFromItems < ActiveRecord::Migration[5.1]
  def change
    remove_column :items, :item_group_id
  end
end
