class ImageHasOneUser < ActiveRecord::Migration[5.0]
  def change
    change_table :images do |t|
      t.belongs_to :user
    end
  end
end
