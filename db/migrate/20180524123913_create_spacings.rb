class CreateSpacings < ActiveRecord::Migration[5.1]
  def change
    create_table :spacings do |t|
      t.string :options
      t.belongs_to :item, foreign_key: true
    end
  end
end
