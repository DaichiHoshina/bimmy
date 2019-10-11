# frozen_string_literal: true

class LikesController < ApplicationController
  def index; end

  def create
    like = Like.new
    like.user_id = current_user.id
    like.post_id = params[:post_id]

    if like.save
      redirect_to posts_path, success: 'いいねしました'
    else
      redirect_to posts_path, danger: 'いいねを解除しました'
    end
  end

  def destroy
    favorite = Favorite.find_by(topic_id: params[:topic_id], user_id: current_user)
    if favorite.destroy
      redirect_to topics_path, success: 'お気に入りを解除しました'
    else
      redirect_to topics_path, danger: 'お気に入りの解除に失敗しました'
    end
  end
end
