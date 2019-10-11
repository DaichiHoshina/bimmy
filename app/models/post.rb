# frozen_string_literal: true

class Post < ApplicationRecord
  validates :description, presence: true

  validates :image, presence: true

  belongs_to :user
  has_many :likes
  has_many :like_users, through: :likes, source: 'user'

  mount_uploader :image, ImageUploader
end
