class UpdateTableCrops < ActiveRecord::Migration[5.1]
  def change
    add_reference :crops, :plot, index: true

    add_reference :crops, :item, index: true

    add_column :crops, :state, :string

    add_column :crops, :present_in_plot, :boolean, default: true

    remove_column :crops, :garden_id
  end
end
