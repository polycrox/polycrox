class CreateAttributes < ActiveRecord::Migration[5.1]
  def change
    create_table :attributes do |t|
      t.belongs_to :item, foreign_key: true
      t.string :name
      t.string :type
    end
  end
end
