class AddNurseryToNurseryItems < ActiveRecord::Migration[5.1]
  def change
    add_column :nursery_items, :nursery_id, :integer
  end
end
