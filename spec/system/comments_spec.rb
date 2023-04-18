require 'rails_helper'

RSpec.describe "Comments", type: :system do
  let(:me) { create(:user) }
  let(:menu) { create(:menu) }
  let(:comment_by_me) { create(:comment, user: me, menu: menu) }
  let(:comment_by_others) { create(:comment, menu: menu) }

  describe 'コメントのCRUD' do
    before do
      comment_by_me
      comment_by_others
      login_as(me)
    end
    describe 'コメントの一覧' do
      it 'コメントの一覧が表示されること' do
        visit menu_path(menu)
        within('#js-table-comment') do
          expect(page).to have_content(comment_by_me.body)
          expect(page).to have_content(comment_by_me.user.name)
        end
      end
    end

    describe 'コメントの作成' do
      it 'コメントを作成できること', js: true do
        visit menu_path(menu)
        fill_in 'comment[body]', with: '新規コメント'
        click_button 'コメントする'
        comment = Comment.last
        within("#comment-#{comment.id}") do
          expect(page).to have_content(me.name)
          expect(page).to have_content('新規コメント')
        end
      end
      it 'コメントの作成に失敗すること', js: true do
        visit menu_path(menu)
        fill_in 'comment[body]', with: ''
        click_button 'コメントする'
        expect(page).to have_content('コメントを入力してください')
      end
    end

    describe 'コメントの編集' do
      describe '他人のコメントの場合' do
        it '編集ボタン・削除ボタンが表示されないこと' do
          visit menu_path(menu)
          within("#comment-#{comment_by_others.id}") do
            expect(page).not_to have_selector('.js-edit-comment-button')
            expect(page).not_to have_selector('.js-delete-comment-button')
          end
        end
      end

      describe '自分のコメントの場合'do
        context '入力値が正常' do
          it 'コメントの編集に成功する' do
            visit menu_path(menu)
            within("#comment-#{comment_by_me.id}") do
              find('.js-edit-comment-button').click
              fill_in 'comment[body]', with: 'test'
              click_button '更新'
              expect(page).to have_content('test')
            end
          end
        end

        context 'コメントが空欄' do
          it 'コメントの編集に失敗する' do
            visit menu_path(menu)
            within("#comment-#{comment_by_me.id}") do
              find('.js-edit-comment-button').click
              fill_in 'comment[body]', with: ''
              click_button '更新'
            end
            expect(page).to have_content('コメントを入力してください')
          end
        end
      end
    end
  end
end
