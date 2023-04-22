require 'rails_helper'

RSpec.describe 'メニュー', type: :system do
  let(:user) { create(:user) }
  let(:menu) { create(:menu, user: user) }

  describe 'メニューの表示' do
    context 'ログインしている場合' do
      it 'タイトルロゴからメニュー一覧へ遷移できること' do
        login_as(user)
        click_on('たばたにあん', match: :first)
        expect(current_path).to eq(root_path)
      end

      context 'メニューが一件もない場合' do
        it '何もない旨のメッセージが表示されること' do
          login_as(user)
          visit menus_path
          expect(page).to have_content('メニューがありません')
        end
      end

      context 'メニューがある場合' do
        it 'メニューの一覧が表示されること' do
          menu
          login_as(user)
          visit menus_path
          expect(page).to have_content(menu.title), 'メニュー一覧画面にメニューのタイトルが表示されていません'
          expect(page).to have_content(menu.user.name), 'メニュー一覧画面に投稿者のフルネームが表示されていません'
        end
      end
    end
  end
end