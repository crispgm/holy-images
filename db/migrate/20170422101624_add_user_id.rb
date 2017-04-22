class AddUserId < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :user_id, :integer, null: false, default: 0
    add_index :comments, [:image_id, :user_id]
  end
end
