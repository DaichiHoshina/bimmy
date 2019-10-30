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

    context '無効な情報が入力されたとき'

    it 'imageが無くても正常に登録できる' do
      post = build(:post, image: nil, user_id: @user.id)
      expect(post).to be_valid
    end

    it 'contentsが999文字で登録できる' do
      post = build(:post, contents: ('a' * 999).to_s, user_id: @user.id)
      expect(post).to be_valid
    end

    it 'contentsが1000文字で登録できる' do
      post = build(:post, contents: ('a' * 1000).to_s, user_id: @user.id)
      expect(post).to be_valid
    end

    it 'titleが無くても正常に登録できる' do
      post = build(:post, title: nil, user_id: @user.id)
      expect(post).to be_valid
    end

    it 'titleが49文字で登録できる' do
      post = build(:post, title: ('a' * 49).to_s, user_id: @user.id)
      expect(post).to be_valid
    end

    it 'titleが50文字で登録できる' do
      post = build(:post, title: ('a' * 50).to_s, user_id: @user.id)
      expect(post).to be_valid
    end
  end
end
