# frozen_string_literal: true

require 'rails_helper'

describe '投稿のシステムテスト', type: :system do
  let(:user) { FactoryBot.create :user }

  describe '投稿の新規作成' do
    before do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
    end

    context '有効な入力をしたとき' do
      before { visit new_post_path }
      it '投稿成功のメッセージが表示される' do
        fill_in '店名', with: 'さとう食堂'
        fill_in '品名', with: 'エビフライ定食'
        fill_in '感想', with: 'とても美味しいエビでした。また行きたいです。'
        attach_file '画像', 'spec/factories/images/test.jpg'
        select '新潟', from: '住所(県名)'
        click_button '投稿'
        expect(page).to have_content('投稿しました')
      end
    end
    context '無効な入力をしたとき' do
      before { visit new_post_path }
      it '投稿失敗のメッセージが表示されること' do
        click_button '投稿'
        expect(page).to have_content('投稿に失敗しました')
      end
    end
  end

  describe '投稿の編集と削除' do
    let(:user) { create(:user) }
    let(:test_post) { create(:post, user_id: user.id) }
    before do
      visit login_path
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'
      visit edit_post_path(test_post.id)
    end
    context '有効な入力をした場合' do
      it '成功のメッセージが表示されること' do
        fill_in '品名', with: 'イカ飯定食大盛り！！'
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
