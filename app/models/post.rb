# frozen_string_literal: true

class Post < ApplicationRecord
  validates :description, presence: true

  validates :image, presence: true

  belongs_to :user
  has_many :likes
  has_many :like_users, through: :likes, source: 'user'

  mount_uploader :image, ImageUploader

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to_active_hash :prefecture

  def self.search(search)
    if search
      where(['title LIKE ?', "%#{search}%"]) # 検索とnameの部分一致を表示。User.は省略
    else
      all
    end
  end
end
