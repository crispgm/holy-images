class UserLocale < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :locale, :string, null: false, default: "zh-CN"
  end
end
