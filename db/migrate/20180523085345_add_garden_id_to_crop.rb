class AddGardenIdToCrop < ActiveRecord::Migration[5.1]
  def change
    add_column :crops, :garden_id, :integer
  end
end
