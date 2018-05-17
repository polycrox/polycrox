class AddFieldsToFidji < ActiveRecord::Migration[5.1]
  def change
    add_column :fidjis, :height, :string
    add_column :fidjis, :min_box, :decimal
    add_column :fidjis, :max_units, :decimal
    add_column :fidjis, :min_units, :decimal
    add_column :fidjis, :cost_units, :integer
    add_column :fidjis, :friends, :string
    add_column :fidjis, :enemies, :string
  end
end
