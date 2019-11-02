# frozen_string_literal: true

class User < ApplicationRecord
  before_save :email_downcase, unless: :uid?

  validates :name, presence: true, unless: :uid?, length: { maximum: 15 }, uniqueness: true
  validates :introduction, unless: :uid?, length: { maximum: 100 }
  # メールアドレスは~@~.~の形で記入
  validates :email, unless: :uid?,
                    format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i },
                    uniqueness: true
  # 8~32文字で英数字を両方１文字以上で記入
  validates :password,  on: :create, unless: :uid?,
                        format: { with: /\A(?=.*?[a-z])(?=.*?\d)[a-z\d]{8,32}+\z/i }

  has_secure_password validations: false

  mount_uploader :image, ImageUploader

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :like_posts, through: :likes, source: 'post'

  # ツイッター認証機能
  def self.find_or_create_from_auth(auth)
    provider = auth[:provider]
    uid = auth[:uid]
    name = auth[:info][:name]
    image = auth[:info][:image]

    find_or_create_by(provider: provider, uid: uid) do |user|
      user.name = name
      user.image_url = image
    end
  end

  def email_downcase
    email.downcase!
  end

  def self.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def self.encrypt(token)
    Digest::SHA256.hexdigest(token.to_s)
  end
end
