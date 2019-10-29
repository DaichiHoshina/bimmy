# frozen_string_literal: true

require 'rails_helper'

describe '投稿画面のシステムテスト', type: :system do
  let(:user1) { FactoryBot.create(:user, name: 'ユーザー1') }
  let!(:post) { FactoryBot.create(:post, post_id: '1') }

  describe '投稿の新規作成' do
    before do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      visit new_post_path(event_app1.id)
    end
    context '自身の参加イベントの出店情報の場合' do
      let(:login_user) { user1 }
      context '有効な入力をしたイベントの場合' do
        it '登録成功のメッセージが表示されること' do
          fill_in '店名', with: 'さとう食堂'
          fill_in '品名', with: 'エビフライ定食'
          fill_in '感想', with: 'とても美味しいエビでした。また行きたいです。'
          click_button '投稿'
          expect(page).to have_content('投稿しました')
        end
      end
      context '無効な入力をしたイベントの場合' do
        it '不正な入力のメッセージが表示されること' do
          click_button '登録'
          expect(page).to have_content('投稿に失敗しました')
        end
      end
    end
  end

  describe '投稿の編集と削除' do
    let(:post) { FactoryBot.create(:post, user: user1) }
    let(:login_user) { user1 }
    before do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      visit edit_post_path(post.id)
    end
    context '有効な入力をした場合' do
      it '成功のメッセージが表示されること' do
        click_button '更新'
        expect(page).to have_content('変更が完了しました')
      end
    end
    context '無効な入力した場合' do
      it '失敗のメッセージが表示されること' do
        fill_in '品名', with: nil
        click_button '更新'
        expect(page).to have_content('変更に失敗しました')
      end
    end
  end
end
