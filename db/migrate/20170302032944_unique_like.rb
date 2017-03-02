class UniqueLike < ActiveRecord::Migration[5.0]
  def change
    add_index :likes, [:image_id, :user_id], unique: true
  end
end
