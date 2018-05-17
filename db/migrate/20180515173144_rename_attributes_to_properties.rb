class RenameAttributesToProperties < ActiveRecord::Migration[5.1]
  def change
    rename_table :attributes, :properties
  end
end
