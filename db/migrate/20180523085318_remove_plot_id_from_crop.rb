class RemovePlotIdFromCrop < ActiveRecord::Migration[5.1]
  def change
    remove_column :crops, :plot_id, :integer
  end
end
