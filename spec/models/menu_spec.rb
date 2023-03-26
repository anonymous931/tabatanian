# == Schema Information
#
# Table name: menus
#
#  id         :integer          not null, primary key
#  content    :text
#  thumbnail  :string
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_menus_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Menu, type: :model do
  describe 'バリデーションの確認' do
    it '正常に登録される' do
      menu = build(:menu)
      expect(menu).to be_valid
      expect(menu.errors).to be_empty
    end

    it 'タイトルが記載されていない場合' do
      menu_without_title = build(:menu, title: "")
      expect(menu_without_title).to be_invalid
      expect(menu_without_title.errors[:title]).to eq ["を入力してください"]
    end

    it 'タイトルが25文字を超える場合' do
      menu_without_title = build(:menu, title: "12345678901234567890123456")
      expect(menu_without_title).to be_invalid
      expect(menu_without_title.errors[:title]).to eq ["は25文字以内で入力してください"]
    end
  end
end
