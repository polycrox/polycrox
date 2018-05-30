class DropTableCropsItemsPlots < ActiveRecord::Migration[5.1]
  def change
    drop_table :crops_items_plots
  end
end
