# frozen_string_literal: true

class Post < ApplicationRecord
  validates :description, presence: true

  validates :image, presence: true

  belongs_to :user
  has_many :likes
  has_many :like_users, through: :likes, source: 'user'
  # has_many :maps

  mount_uploader :image, ImageUploader

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  # 検索機能
  def self.search(search)
    if search
      where(['prefecture_id LIKE ?', "%#{params[:weather_key]}%"])
    else
      all
    end
  end
end
