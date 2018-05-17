class CreatePlots < ActiveRecord::Migration[5.1]
  def change
    create_table :plots do |t|
      t.string :name
      t.integer :length_cm
      t.integer :width_cm
      t.belongs_to :garden, foreign_key: true

      t.timestamps
    end
  end
end
