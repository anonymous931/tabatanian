require 'rails_helper'

RSpec.describe "Profiles", type: :system do
  let(:user) { create(:user) }
  let(:profile) { create(:profile) }

  describe 'ログイン前' do
    context 'マイページにアクセス' do
      it 'マイページへのアクセスが失敗する' do
        visit user_path(user)
        expect(page).to have_content 'ログインしてください'
        expect(current_path).to eq login_path
      end
    end

    context 'プロフィール編集ページにアクセス' do
      it 'プロフィール編集ページへのアクセスが失敗する' do
        visit edit_user_path(user)
        expect(page).to have_content 'ログインしてください'
        expect(current_path).to eq login_path
      end
    end
  end

  describe 'ログイン後' do
    before { login_as(user) }

    context '他ユーザーのプロフィールページにアクセス' do
      let!(:other_user) { create(:user, email: "other_user@example.com") }
      let!(:other_profile) { create(:profile, user: other_user) }

      it '編集ページへのアクセスが失敗する' do
        visit edit_user_path(other_user)
        expect(page).to have_content 'アクセスできません'
        expect(current_path).to eq root_path
      end

      it 'マイページに編集等のリンクが存在しない' do
        visit edit_user_path(other_user)
        expect(page).to have_no_link 'プロフィールを編集', href: edit_user_path(other_user)
        expect(page).to have_no_link '投稿', href: new_menu_path
        expect(page).not_to have_content '編集'
        expect(page).not_to have_content '削除'
      end
    end

    describe 'プロフィール編集' do
      context 'フォームの入力値が正常' do
        it 'プロフィール編集が成功する' do
          visit edit_user_path(user)
          fill_in '名前', with: 'test_name'
          fill_in '自己紹介', with: 'test_introduction'
          fill_in 'user_profile_attributes_weight', with: 50.5
          fill_in 'user_profile_attributes_fat', with: 17.4
          fill_in 'user_profile_attributes_target_weight', with: 45.5
          fill_in 'user_profile_attributes_target_fat', with: 14.4
          fill_in 'user_profile_attributes_deadline', with: '002023-04-12'
          click_button '登録'
          expect(page).to have_content 'プロフィールを更新しました'
          expect(page).to have_content 'test_name'
          expect(page).to have_content 'test_introduction'
          expect(page).to have_content '体重：50.5kg'
          expect(page).to have_content '体脂肪率：17.4%'
          expect(page).to have_content '体重：45.5kg'
          expect(page).to have_content '体脂肪率：14.4%'
          expect(page).to have_content '04月12日'
          expect(current_path).to eq user_path(user)
        end
      end

      context '名前が未入力' do
        it 'プロフィール編集が失敗する' do
          visit edit_user_path(user)
          fill_in '名前', with: ''
          click_button '登録'
          expect(page).to have_content 'プロフィールを更新できませんでした'
          expect(page).to have_content '名前を入力してください'
        end
      end
    end
  end
end
