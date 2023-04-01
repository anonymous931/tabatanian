# == Schema Information
#
# Table name: comments
#
#  id         :integer          not null, primary key
#  body       :text             not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  menu_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_comments_on_menu_id  (menu_id)
#  index_comments_on_user_id  (user_id)
#
# Foreign Keys
#
#  menu_id  (menu_id => menus.id)
#  user_id  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Comment, type: :model do
  context '全てのフィールドが有効な場合' do
    it '有効であること' do
      comment = build(:comment)
      expect(comment).to be_valid
    end
  end

  context '本文が存在しない場合' do
    it '無効であること' do
      comment = build(:comment, body: nil)
      expect(comment).to be_invalid
      expect(comment.errors[:body]).to include('を入力してください')
    end
  end

  context '本文が200文字以内の場合' do
    it '有効であること' do
      comment = build(:comment, body: 'a' * 200)
      expect(comment).to be_valid
    end
  end

  context '本文が201文字以上の場合' do
    it '無効であること' do
      comment = build(:comment, body: 'a' * 201)
      expect(comment).to be_invalid
      expect(comment.errors[:body]).to include('は200文字以内で入力してください')
    end
  end
end
