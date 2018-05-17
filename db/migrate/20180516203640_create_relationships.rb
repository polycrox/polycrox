class CreateRelationships < ActiveRecord::Migration[5.1]
  def change
    create_table :relationships do |t|
      t.belongs_to :item, foreign_key: true
      t.boolean :is_friend
      t.integer :other_item_id
      t.integer :group_id
    end
  end
end
