require 'rails_helper'

RSpec.describe '掲示板', type: :system do
  let(:user) { create(:user) }
  let(:menu) { create(:menu, user: user) }

  describe '掲示板の表示' do
    context 'ログインしている場合' do
      it 'タイトルロゴから掲示板一覧へ遷移できること' do
        login_as(user)
        click_on('たばたにあん')
        expect(current_path).to eq(root_path)
      end

      context '掲示板が一件もない場合' do
        it '何もない旨のメッセージが表示されること' do
          login_as(user)
          visit menus_path
          expect(page).to have_content('メニューがありません')
        end
      end

      context '掲示板がある場合' do
        it '掲示板の一覧が表示されること' do
          menu
          login_as(user)
          visit menus_path
          expect(page).to have_content(menu.title), '掲示板一覧画面に掲示板のタイトルが表示されていません'
          expect(page).to have_content(menu.user.name), '掲示板一覧画面に投稿者のフルネームが表示されていません'
        end
      end
    end
  end
end