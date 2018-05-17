class CreateFormProperties < ActiveRecord::Migration[5.1]
  def change
    create_table :form_properties do |t|
      t.string :name
      t.string :options
      t.boolean :multiple
      t.boolean :type
    end
  end
end
