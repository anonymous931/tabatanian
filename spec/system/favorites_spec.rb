require 'rails_helper'

RSpec.describe "Favorites", type: :system do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user, email: "other_user@example.com") }
  let!(:menu) { create(:menu, user_id: other_user.id)}

  describe 'お気に入り機能の確認' do
    context '未ログイン' do
      it 'お気に入り一覧画面にアクセスできない' do
        visit favorites_menus_path
        expect(page).to have_content 'ログインしてください'
        expect(current_path).to eq login_path
      end
    end

    context 'ログイン済み' do
      before { login_as(user) }

      it 'メニュー一覧画面でお気に入り登録、お気に入り解除ができる' do
        visit root_path
        find('.favorite').click
        expect(page).to have_selector '.unfavorite'
        expect(user.favorites.count).to eq(1)
        find('.unfavorite').click
        expect(page).to have_selector '.favorite'
        expect(user.favorites.count).to eq(0)
      end

      it 'お気に入り一覧画面が正常に表示される' do
        visit root_path
        find('.favorite').click
        expect(page).to have_selector '.unfavorite'
        expect(user.favorites.count).to eq(1)
        visit favorites_menus_path
        expect(page).to have_selector '.unfavorite'
        expect(page).to have_content menu.title
        expect(page).to have_content menu.user.name
      end

      it 'お気に入り一覧画面でお気に入り解除ができる' do
        visit root_path
        find('.favorite').click
        expect(page).to have_selector '.unfavorite'
        expect(user.favorites.count).to eq(1)
        visit favorites_menus_path
        find('.unfavorite').click
        expect(page).not_to have_selector '.unfavorite'
        expect(user.favorites.count).to eq(0)
      end
    end
  end
end
