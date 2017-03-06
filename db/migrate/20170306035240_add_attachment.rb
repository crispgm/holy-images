class AddAttachment < ActiveRecord::Migration[5.0]
  def change
    add_attachment :images, :img_file 
  end
end
