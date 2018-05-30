class CropItemPlot < ApplicationRecord

  self.table_name = 'crops_items_plots'
  belongs_to :crop, dependent: :destroy

  def self.find_items_for_plot_and_crop(plot_id, crop_id)
    return CropItemPlot.select(:item_id)
      .where('plot_id = ? and crop_id = ?', plot_id, crop_id)
      .map do |result|
        Item.find(result.item_id) #.to_json(except: [:created_at, :updated_at])
      end
  end
end