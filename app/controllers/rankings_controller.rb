# frozen_string_literal: true

PER = 5

class RankingsController < ApplicationController
  def index
    @likes = Post.find(Like.group(:post_id)
                 .order('count(post_id) desc')
                 .limit(5)
                 .pluck(:post_id))
  end
end
