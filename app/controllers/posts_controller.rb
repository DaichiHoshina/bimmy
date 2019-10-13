# frozen_string_literal: true

# 投稿5個で次のページ
PER = 5

class PostsController < ApplicationController
  def index
    @posts = Post.page(params[:page]).per(PER).order(created_at: :desc)
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id
    if @post.save
      redirect_to posts_path, success: '投稿しました'
    else
      flash.now[:danger] = '投稿に失敗しました'
      render :new
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :image, :city, :prefecture_id)
  end
end
