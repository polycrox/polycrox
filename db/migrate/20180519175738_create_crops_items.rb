class CreateCropsItems < ActiveRecord::Migration[5.1]
  def change
    create_table :crops_items do |t|
      t.belongs_to :crop, foreign_key: true
      t.belongs_to :item, foreign_key: true
    end
  end
end
