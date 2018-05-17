class AddColumnToProperties < ActiveRecord::Migration[5.1]
  def change
    add_reference :properties, :form_property, foreign_key: true
  end
end
