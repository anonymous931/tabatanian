require 'rails_helper'

RSpec.describe "Relationships", type: :system do
  let(:user) { create(:user) }
  let!(:other_user) { create(:user, email: "other_user@example.com") }

  describe 'フォロー機能の確認' do
    context '未ログイン' do
      it 'フォロー一覧画面にアクセスできない' do
        visit follower_user_relationships_path(user)
        expect(page).to have_content 'ログインしてください'
        expect(current_path).to eq login_path
      end
    end

    context 'ログイン済み' do
      before { login_as(user) }

      it 'ユーザー詳細画面でフォロー、フォロー解除ができる' do
        visit user_path(other_user)
        click_link 'フォローする'
        expect(page).to have_content 'フォローを外す'
        expect(other_user.passive_relationships.count).to eq(1)
        expect(user.active_relationships.count).to eq(1)
        click_link 'フォローを外す'
        expect(page).to have_content 'フォローする'
        expect(other_user.passive_relationships.count).to eq(0)
        expect(user.active_relationships.count).to eq(0)
      end
    end
  end
end
