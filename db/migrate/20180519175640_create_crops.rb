class CreateCrops < ActiveRecord::Migration[5.1]
  def change
    create_table :crops do |t|
      t.date :date
      t.belongs_to :plot, foreign_key: true
    end
  end
end
