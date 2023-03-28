require 'rails_helper'

RSpec.describe "Profiles", type: :system do
  let(:user) { create(:user) }
  let(:profile) { create(:profile) }

  describe 'ログイン前' do
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

    context '他ユーザーのメニュー編集ページにアクセス' do
      let!(:other_user) { create(:user, email: "other_user@example.com") }
      let!(:other_profile) { create(:profile, user: other_user) }

      it '編集ページへのアクセスが失敗する' do
        visit edit_user_path(other_user)
        expect(page).to have_content 'アクセスできません'
        expect(current_path).to eq root_path
      end
    end
  end
end
