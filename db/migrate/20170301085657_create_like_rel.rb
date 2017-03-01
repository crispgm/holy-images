class CreateLikeRel < ActiveRecord::Migration[5.0]
  def change
    create_table :like_rels do |t|
      t.belongs_to :user, index: true
      t.belongs_to :image, index: true
      t.integer :status, null: false, default: 0
      t.timestamps
    end
  end
end
