class AddColumnValueToAttributes < ActiveRecord::Migration[5.1]
  def change
    add_column :attributes, :value, :string
  end
end
