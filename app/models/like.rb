# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :topic
  belongs_to :user
end
