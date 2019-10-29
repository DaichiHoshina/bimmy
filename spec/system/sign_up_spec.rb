# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザー登録のシステムテスト', type: :system do
  before do
    visit new_user_path
  end

  describe '有効なユーザー登録の場合' do
    before do
      fill_in '名前', with: 'テストユーザ1'
      fill_in 'メールアドレス', with: 'test1@example.com'
      fill_in 'パスワード', with: 'hogehoge1234'
      click_button '登録'
    end

    it '成功メッセージが表示されること' do
      expect(page).to have_content '登録が完了しました'
    end
    it 'ログアウトが表示されること' do
      expect(page).to have_content 'ログアウト'
    end
    it 'ユーザーが表示されること' do
      expect(page).to have_content 'テストユーザ1'
    end
  end

  describe '無効なユーザー登録の場合' do
    before do
      fill_in '名前', with: ''
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: ''
      click_button '登録'
    end

    it '失敗メッセージが表示されること' do
      expect(page).to have_content '登録に失敗しました'
    end
    it 'ログインが表示されること' do
      expect(page).to have_content 'ログイン'
    end
    it '新規登録が表示されること' do
      expect(page).to have_content '新規登録'
    end
  end
end
