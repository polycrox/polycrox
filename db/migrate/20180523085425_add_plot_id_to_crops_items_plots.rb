class AddPlotIdToCropsItemsPlots < ActiveRecord::Migration[5.1]
  def change
    add_column :crops_items_plots, :plot_id, :integer
  end
end
