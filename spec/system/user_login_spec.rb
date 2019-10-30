# frozen_string_literal: true

require 'rails_helper'

describe 'ユーザーログイン機能', type: :feature do
  let(:user) { FactoryBot.create :user }
  before { visit login_path }

  context '有効な情報を送信したとき' do
    it 'ログアウトが表示される' do
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'

      expect(page).to have_content 'ログインに成功しました'
      expect(page).to have_content 'ログアウト'
      expect(page).to have_content user.name.to_s
    end
  end

  context '無効な情報を送信したとき' do
    it 'メールアドレスが無効である' do
      fill_in 'メールアドレス', with: ''
      fill_in 'パスワード', with: user.password
      click_button 'ログイン'

      expect(page).to have_content 'ログインに失敗しました'
    end

    it 'パスワードが無効である' do
      fill_in 'メールアドレス', with: user.email
      fill_in 'パスワード', with: ''
      click_button 'ログイン'

      expect(page).to have_content 'ログインに失敗しました'
    end
  end
end
