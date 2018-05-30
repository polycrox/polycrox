class RenameCropsItemsToCropsItemsPlots < ActiveRecord::Migration[5.1]
  def change
    rename_table :crops_items, :crops_items_plots
  end
end
