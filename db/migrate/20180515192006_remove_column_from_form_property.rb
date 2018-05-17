class RemoveColumnFromFormProperty < ActiveRecord::Migration[5.1]
  def change
    remove_column :form_properties, :type, :string
  end
end
