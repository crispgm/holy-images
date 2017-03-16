class AddInvite < ActiveRecord::Migration[5.0]
  def change
  	add_column :users, :invited_by, :integer, null: false, default: 0
  end
end
