# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'ユーザー登録', type: :model do
  let(:post) { FactoryBot.create :post }

  context '有効な情報が入力されたとき' do
    it 'ユーザー名、メールアドレス、パスワードが入力され、登録出来る' do
      user = User.create(
        name: 'テストユーザー',
        email: 'test@example.com',
        password: 'test1234'
      )
      expect(user).to be_valid
    end
  end

  context '無効な情報が入力されたとき' do
    it 'ユーザー名がないためエラーになる' do
      user = User.new(name: nil)
      expect(user.valid?).to eq(false)
    end

    it 'メールアドレスがないためエラーになる' do
      user = User.new(email: nil)
      expect(user.valid?).to eq(false)
    end

    it 'パスワードがないためエラーになる' do
      user = User.new(password: nil)
      expect(user.valid?).to eq(false)
    end

    it '名前が16文字以上なためエラーになる' do
      user = User.create(
        name: 'テストユーザーテストユーザーテストユーザー',
        email: 'test@example.com',
        password: 'test1234'
      )
      expect(user).not_to be_valid
    end

    it 'メールアドレスで.がないためエラーになる' do
      user = User.create(
        name: 'テストユーザー',
        email: 'test＠examplecom',
        password: 'test1234'
      )
      expect(user).not_to be_valid
    end

    it 'メールアドレスで@がないためエラーになる' do
      user = User.create(
        name: 'テストユーザー',
        email: 'testexample.com',
        password: 'test1234'
      )
      expect(user).not_to be_valid
    end

    it 'パスワードで数字のみでないためエラーになる' do
      user = User.create(
        name: 'テストユーザー',
        email: 'testexamplecom',
        password: '12341234'
      )
      expect(user).not_to be_valid
    end

    it 'パスワードで英語のみであるためエラーになる' do
      user = User.create(
        name: 'テストユーザー',
        email: 'testexamplecom',
        password: 'testtest'
      )
      expect(user).not_to be_valid
    end

    it 'パスワードで7文字以下であるためエラーになる' do
      user = User.create(
        name: 'テストユーザー',
        email: 'testexamplecom',
        password: 'test123'
      )
      expect(user).not_to be_valid
    end

    it 'パスワードで33文字以上あるためエラーになる' do
      user = User.create(
        name: 'テストユーザー',
        email: 'testexamplecom',
        password: 'testtest12341234testtest12341234testtest12341234'
      )
      expect(user).not_to be_valid
    end

    it 'メールアドレスの重複は無効であること' do
      User.create(
        name: 'テストユーザー1',
        email: 'testexamplecom',
        password: 'test1234'
      )
      user = User.create(
        name: 'テストユーザー2',
        email: 'testexamplecom',
        password: 'test123456'
      )
      expect(user).not_to be_valid
    end
  end
end
