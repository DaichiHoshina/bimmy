# frozen_string_literal: true

# 投稿5個で次のページ
PER = 5

class PostsController < ApplicationController
  def index
    # 県名検索機能
    @posts = if params[:prefecture_id]
               # 検索した県名をviewへ渡す
               @int = Post.new(prefecture_id: params[:prefecture_id])
               @name = @int.prefecture.name
               @post = Post.where('prefecture_id IN(?)', params[:prefecture_id])
               @count = @post.count

               Post.where('prefecture_id IN(?)', params[:prefecture_id]).order(created_at: :desc)

             else
               Post.page(params[:page]).per(PER).order(created_at: :desc)
             end
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

  def destroy
    @post = Post.find_by(id: params[:id])
    # 投稿者本人のみが削除可能
    if @post.user_id == current_user.id
      if @post.destroy
        redirect_to user_path(current_user.id), success: '投稿を削除しました'
      else
        flash.now[:danger] = '投稿の削除に失敗しました'
        render :edit
      end
    else
      redirect_to user_path(current_user.id), danger: 'あなたに権限はありません'
    end
  end

  private

  def post_params
    params.require(:post).permit(:title, :description, :image, :city, :prefecture_id, :rate)
  end
end
