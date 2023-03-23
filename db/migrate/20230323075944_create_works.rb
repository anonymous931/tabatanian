class CreateWorks < ActiveRecord::Migration[6.1]
  def change
    create_table :works do |t|
      t.references :menu, null: false, foreign_key: true
      t.string :title,    null: false
      t.text :content

      t.timestamps
    end
  end
end
