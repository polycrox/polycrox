class AddDescriptionToFormProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :form_properties, :description, :text
  end
end
