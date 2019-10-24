# frozen_string_literal: true

class Post < ApplicationRecord
  validates :description, presence: true, length: { maximum: 200 }
  validates :title, presence: true, length: { maximum: 30 }
  validates :image, presence: true
  validates :store, length: { maximum: 30 }
  validates :rate, presence: true

  belongs_to :user
  has_many :likes, dependent: :destroy
  has_many :like_users, through: :likes, source: 'user'
  has_one :map

  def favorited_by?(user)
    favorites.where(user_id: user.id).exists?
  end

  mount_uploader :image, ImageUploader

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture
end
