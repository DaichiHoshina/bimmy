# frozen_string_literal: true

class Post < ApplicationRecord
  validates :description, presence: true

  validates :image, presence: true

  belongs_to :user

  mount_uploader :image, ImageUploader
end
