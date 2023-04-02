# == Schema Information
#
# Table name: favorites
#
#  id         :integer          not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  menu_id    :integer          not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_favorites_on_menu_id              (menu_id)
#  index_favorites_on_user_id              (user_id)
#  index_favorites_on_user_id_and_menu_id  (user_id,menu_id) UNIQUE
#
# Foreign Keys
#
#  menu_id  (menu_id => menus.id)
#  user_id  (user_id => users.id)
#
require 'rails_helper'

RSpec.describe Favorite, type: :model do
  describe 'バリデーションの確認' do
    context '入力値が正常' do
      it '正常に登録される' do
        favorite = build(:favorite)
        expect(favorite).to be_valid
        expect(favorite.errors).to be_empty
      end
    end

    context 'user_idがnil' do
      it 'エラーになる' do
        favorite = build(:favorite, user_id: "")
        expect(favorite).to be_invalid
        expect(favorite.errors).not_to be_empty
      end
    end

    context 'menu_idがnil' do
      it 'エラーになる' do
        favorite = build(:favorite, menu_id: "")
        expect(favorite).to be_invalid
        expect(favorite.errors).not_to be_empty
      end
    end

    context 'user_idとmenu_idが同じ値' do
      it 'エラーになる' do
        favorite = build(:favorite, user_id: 2)
        expect(favorite).to be_invalid
        expect(favorite.errors).not_to be_empty
      end
    end
  end
end
