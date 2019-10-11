# frozen_string_literal: true

class Post < ApplicationRecord
  validates :description, presence: true

  validates :image, presence: true

  belongs_to :user
  has_many :favorites
  has_many :favorite_posts, through: :favorites, source: 'post'
  
  mount_uploader :image, ImageUploader
end
