# frozen_string_literal: true

PER = 5

class RankingsController < ApplicationController
  def index
    @like_all = Post.all.includes(:user, :likes, :like_users)
    @likes = @like_all.find(Like.group(:post_id)
                 .order('count(post_id) desc')
                 .limit(5)
                 .pluck(:post_id))
  end
end
