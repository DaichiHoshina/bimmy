# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validation' do
    it 'ユーザー名、メールアドレス、パスワードが有効であること' do
      user = User.create(
        name: 'テストユーザー',
        email: 'test@example.com',
        password: 'test1234'
      )
      expect(user).to be_valid
    end

    it 'ユーザー名がなければ無効であること' do
      user = User.new(name: nil)
      expect(user.valid?).to eq(false)
    end

    it 'メールアドレスがなければ無効であること' do
      user = User.new(email: nil)
      expect(user.valid?).to eq(false)
    end

    it 'パスワードがなければ無効であること' do
      user = User.new(password: nil)
      expect(user.valid?).to eq(false)
    end

    it '名前は16文字以上は無効であること' do
      user = User.create(
        name: 'テストユーザーテストユーザーテストユーザー',
        email: 'test@example.com',
        password: 'test1234'
      )
      expect(user).not_to be_valid
    end

    it 'メールアドレスで.がないと無効であること' do
      user = User.create(
        name: 'テストユーザー',
        email: 'test＠examplecom',
        password: 'test1234'
      )
      expect(user).not_to be_valid
    end

    it 'メールアドレスで@がないと無効であること' do
      user = User.create(
        name: 'テストユーザー',
        email: 'testexample.com',
        password: 'test1234'
      )
      expect(user).not_to be_valid
    end

    it 'パスワードで数字のみは無効であること' do
      user = User.create(
        name: 'テストユーザー',
        email: 'testexamplecom',
        password: '12341234'
      )
      expect(user).not_to be_valid
    end

    it 'パスワードで英語のみは無効であること' do
      user = User.create(
        name: 'テストユーザー',
        email: 'testexamplecom',
        password: 'testtest'
      )
      expect(user).not_to be_valid
    end

    it 'パスワードで7文字以下は無効であること' do
      user = User.create(
        name: 'テストユーザー',
        email: 'testexamplecom',
        password: 'test123'
      )
      expect(user).not_to be_valid
    end

    it 'パスワードで33文字以上は無効であること' do
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
