class RenameItemGroupsToGroups < ActiveRecord::Migration[5.1]
  def change
    rename_table :item_groups, :groups
    rename_column :items_groups, :item_group_id, :group_id
  end
end
