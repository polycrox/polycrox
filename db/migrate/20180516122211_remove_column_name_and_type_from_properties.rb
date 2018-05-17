class RemoveColumnNameAndTypeFromProperties < ActiveRecord::Migration[5.1]
  def change
    remove_column :properties, :type
    remove_column :properties, :name
  end
end
