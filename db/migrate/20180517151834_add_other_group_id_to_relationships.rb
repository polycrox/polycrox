class AddOtherGroupIdToRelationships < ActiveRecord::Migration[5.1]
  def change
    add_column :relationships, :other_group_id, :integer
  end
end
