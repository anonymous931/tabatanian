# == Schema Information
#
# Table name: works
#
#  id         :integer          not null, primary key
#  content    :text
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  menu_id    :integer          not null
#
# Indexes
#
#  index_works_on_menu_id  (menu_id)
#
# Foreign Keys
#
#  menu_id  (menu_id => menus.id)
#
require 'rails_helper'

RSpec.describe Work, type: :model do
  describe 'バリデーションの確認' do
    it '正常に登録される' do
      work = build(:work)
      expect(work).to be_valid
      expect(work.errors).to be_empty
    end

    it 'タイトルが記載されていない場合' do
      work_without_title = build(:work, title: "")
      expect(work_without_title).to be_invalid
      expect(work_without_title.errors[:title]).to eq ["を入力してください"]
    end

    it 'タイトルが25文字を超える場合' do
      work_without_title = build(:work, title: "12345678901234567890123456")
      expect(work_without_title).to be_invalid
      expect(work_without_title.errors[:title]).to eq ["は25文字以内で入力してください"]
    end
  end
end
