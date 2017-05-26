class AddSourceUser < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :event_from_user_id, :integer, null: false, default: 0
  end
end
