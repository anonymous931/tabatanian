class CreateMenus < ActiveRecord::Migration[6.1]
  def change
    create_table :menus do |t|
      t.references :user, null: false, foreign_key: true
      t.string :title,    null: false
      t.text :content
      t.string :thumbnail

      t.timestamps
    end
  end
end
