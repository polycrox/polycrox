class CreateFidjis < ActiveRecord::Migration[5.1]
  def change
    create_table :fidjis do |t|
      t.string :name
      t.string :family

      t.timestamps
    end
  end
end
