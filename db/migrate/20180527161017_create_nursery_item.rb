class CreateNurseryItem < ActiveRecord::Migration[5.1]
  def change
    create_table :nursery_items do |t|
      t.belongs_to :item, foreign_key: true
      t.string :cultivar
      t.integer :quantity, default: 1
      t.date :birthdate
      t.integer :happiness
      t.string :state
      t.string :type
    end
  end
end
