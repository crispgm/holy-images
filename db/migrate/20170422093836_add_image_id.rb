class AddImageId < ActiveRecord::Migration[5.0]
  def change
    add_column :comments, :image_id, :integer, null: false, default: 0
  end
end
