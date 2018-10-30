class DropImageUrl < ActiveRecord::Migration[5.0]
  def change
    remove_column :images, :url, :string
  end
end
