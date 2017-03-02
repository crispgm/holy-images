class LikeRelation < ActiveRecord::Migration[5.0]
  def change
    change_table :likes do |t|
      t.belongs_to :user
      t.belongs_to :image
    end
  end
end
