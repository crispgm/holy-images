class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.integer :user_id
      t.integer :event_type
      t.integer :event_id
      t.integer :status

      t.timestamps

      t.index ["user_id"], name: "index_notifications_on_user_id",  using: :btree
    end
  end
end
