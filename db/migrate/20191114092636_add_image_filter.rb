class AddImageFilter < ActiveRecord::Migration[5.0]
  def change
    add_column :images, :filter, :integer, null: false, default: 0
  end
end
