class CreateItemsGroups < ActiveRecord::Migration[5.1]
  def change
    create_table :items_groups do |t|
      t.belongs_to :item
      t.belongs_to :item_group
    end
  end
end
