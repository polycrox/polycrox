class AddHtmlToFormProperties < ActiveRecord::Migration[5.1]
  def change
    add_column :form_properties, :html, :string
  end
end
