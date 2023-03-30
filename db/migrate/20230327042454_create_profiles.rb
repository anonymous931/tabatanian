class CreateProfiles < ActiveRecord::Migration[6.1]
  def change
    create_table :profiles do |t|
      t.references :user, null: false, foreign_key: true
      t.text :introduction
      t.float :weight
      t.float :fat
      t.float :target_weight
      t.float :target_fat
      t.date :deadline

      t.timestamps
    end
  end
end
