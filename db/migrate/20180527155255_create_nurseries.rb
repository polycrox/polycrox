class CreateNurseries < ActiveRecord::Migration[5.1]
  def change
    create_table :nurseries do |t|
      t.belongs_to :garden, foreign_key: true
    end
  end
end
