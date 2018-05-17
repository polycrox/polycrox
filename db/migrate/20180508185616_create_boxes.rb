class CreateBoxes < ActiveRecord::Migration[5.1]
  def change
    create_table :boxes do |t|
      t.integer :pos_x
      t.integer :pos_y
      t.belongs_to :plot, foreign_key: true

      t.timestamps
    end
  end
end
