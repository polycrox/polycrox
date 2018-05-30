class AddActiveToCrops < ActiveRecord::Migration[5.1]
  def change
    add_column :crops, :active, :boolean, default: false
  end
end
