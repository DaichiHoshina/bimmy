# frozen_string_literal: true

class User < ApplicationRecord
  validates :name, presence: true, length: { maximum: 15 }, uniqueness: true

  validates :introduction, length: { maximum: 100 }

  # メールアドレスは~@~.~の形で記入
  validates :email, presence: true,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true

  # 8~32文字で英数字を両方１文字以上で記入
  validates :password, presence: true, on: :create,
                       format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}+\z/i }

  has_secure_password

  mount_uploader :image, ImageUploader

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: 'post'
end
