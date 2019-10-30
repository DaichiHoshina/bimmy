# frozen_string_literal: true

require 'rails_helper'

describe '投稿機能', type: :model do
  before do
    @user = create(:user)
  end

  context '有効な情報が入力されたとき' do
    it '必要なデータが入力され、正常に登録できる' do
      post = build(:post, user_id: @user.id)
      expect(post).to be_valid
    end
  end

  context '無効な情報が入力されたとき' do
    it '感想がないためエラーになる' do
      post = build(:post, description: nil, user_id: @user.id)
      expect(post.valid?).to eq(false)
    end

    it '画像がないためエラーになる' do
      post = build(:post, image: nil, user_id: @user.id)
      expect(post.valid?).to eq(false)
    end

    it '品名がないためエラーになる' do
      post = build(:post, title: nil, user_id: @user.id)
      expect(post.valid?).to eq(false)
    end

    it '評価がないためエラーになる' do
      post = build(:post, rate: nil, user_id: @user.id)
      expect(post.valid?).to eq(false)
    end

    it '品名が21文字以上でエラーになる' do
      post = build(:post, title: ('a' * 21), user_id: @user.id)
      expect(post.valid?).to eq(false)
    end

    it '感想が201文字以上でエラーになる' do
      post = build(:post, description: ('a' * 201), user_id: @user.id)
      expect(post.valid?).to eq(false)
    end

    it '店名が21文字以上でエラーになる' do
      post = build(:post, store: ('a' * 21), user_id: @user.id)
      expect(post.valid?).to eq(false)
    end
  end
end
