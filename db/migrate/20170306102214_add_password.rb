class AddPassword < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :password, :string, null: false, default: ""
  end
end
