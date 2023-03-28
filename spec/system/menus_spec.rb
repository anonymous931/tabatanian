require 'rails_helper'

RSpec.describe "Menu", type: :system do
  let(:user) { create(:user) }
  let(:menu) { create(:menu) }

  describe 'ログイン前' do
    describe 'ページ遷移確認' do
      context 'メニューの新規登録ページにアクセス' do
        it '新規登録ページへのアクセスが失敗する' do
          visit new_menu_path
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end
      end

      context 'メニューの編集ページにアクセス' do
        it '編集ページへのアクセスが失敗する' do
          visit edit_menu_path(menu)
          expect(page).to have_content('ログインしてください')
          expect(current_path).to eq login_path
        end
      end

      context 'メニューの詳細ページにアクセス' do
        it 'メニューの詳細情報が表示される' do
          visit menu_path(menu)
          expect(page).to have_content menu.title
          expect(current_path).to eq menu_path(menu)
        end
      end

      context 'メニューの一覧ページにアクセス' do
        it 'すべてのユーザーのメニュー情報が表示される' do
          menu_list = create_list(:menu, 3)
          visit menus_path
          expect(page).to have_content menu_list[0].title
          expect(page).to have_content menu_list[1].title
          expect(page).to have_content menu_list[2].title
          expect(current_path).to eq menus_path
        end
      end
    end
  end

  describe 'ログイン後' do
    before { login_as(user) }

    describe 'メニュー新規登録' do
      context 'フォームの入力値が正常' do
        it 'メニューの新規作成が成功する' do
          visit new_menu_path
          click_link 'ワークの追加'
          fill_in 'メニュータイトル', with: 'test_title'
          fill_in 'メニュー詳細', with: 'test_content'
          fill_in 'ワーク名', with: 'test_work_title'
          fill_in 'ワーク詳細', with: 'test_work_content'
          click_button '登録'
          expect(page).to have_content 'test_title'
          expect(page).to have_content 'test_content'
          expect(page).to have_content 'test_work_title'
          click_button 'test_work_title'
          expect(page).to have_content 'test_work_content'
          expect(current_path).to eq '/menus/1'
        end
      end

      context 'メニュータイトルが未入力' do
        it 'メニューの新規作成が失敗する' do
          visit new_menu_path
          fill_in 'メニュータイトル', with: ''
          fill_in 'メニュー詳細', with: 'test_content'
          click_button '登録'
          expect(page).to have_content "メニュータイトルを入力してください"
          expect(current_path).to eq menus_path
        end
      end

      context 'ワーク名が未入力' do
        it 'メニューの新規作成が失敗する' do
          visit new_menu_path
          click_link 'ワークの追加'
          fill_in 'メニュータイトル', with: 'test_title'
          fill_in 'メニュー詳細', with: 'test_content'
          fill_in 'ワーク名', with: ''
          fill_in 'ワーク詳細', with: 'test_work_content'
          click_button '登録'
          expect(page).to have_content "ワーク名を入力してください"
          expect(current_path).to eq menus_path
        end
      end
    end

    describe 'メニュー編集' do
      let!(:menu) { create(:menu, user: user) }
      let(:other_menu) { create(:menu, user: user) }
      before { visit edit_menu_path(menu) }

      context 'フォームの入力値が正常' do
        it 'メニューの編集が成功する' do
          fill_in 'メニュータイトル', with: 'updated_title'
          click_button '登録'
          expect(page).to have_content 'updated_title'
          expect(page).to have_content 'メニューを更新しました'
          expect(current_path).to eq menu_path(menu)
        end
      end

      context 'タイトルが未入力' do
        it 'メニューの編集が失敗する' do
          fill_in 'メニュータイトル', with: nil
          click_button '登録'
          expect(page).to have_content "メニュータイトルを入力してください"
          expect(current_path).to eq menu_path(menu)
        end
      end

      context '他ユーザーのメニュー編集ページにアクセス' do
        let!(:other_user) { create(:user, email: "other_user@example.com") }
        let!(:other_menu) { create(:menu, user: other_user) }

        it '編集ページへのアクセスが失敗する' do
          visit edit_menu_path(other_menu)
          expect(page).to have_content 'アクセスできません'
          expect(current_path).to eq root_path
        end
      end
    end

    describe 'メニュー削除' do
      let!(:menu) { create(:menu, user: user) }

      it 'メニューの削除が成功する' do
        visit menu_path(menu)
        click_link '削除'
        expect(page.accept_confirm).to eq '本当に削除しますか？'
        expect(page).to have_content 'メニューを削除しました'
        expect(current_path).to eq menus_path
        expect(page).not_to have_content menu.title
      end
    end
  end
end
