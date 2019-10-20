# frozen_string_literal: true

# 投稿5個で次のページ
PER = 5

class PostsController < ApplicationController
  before_action :authenticate_user, only: %i[edit update]

  def index
    # 県名検索機能
    if params[:prefecture_id]

      # 検索した県名をviewへ渡す
      @int = Post.new(prefecture_id: params[:prefecture_id])
      @name = @int.prefecture.name

      @post = Post.where('prefecture_id IN(?)', params[:prefecture_id])
      @count = @post.count
      @posts_search = Post.where('prefecture_id IN(?)', params[:prefecture_id]).order(created_at: :desc)
      @posts = @posts_search.page(params[:page]).per(PER).order(created_at: :desc)
      @posts_count = @posts_search.length

    else
      @posts = Post.page(params[:page]).per(PER).order(created_at: :desc)
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

  def edit
    @post = Post.find(params[:id])

    # 投稿者本人のみ編集可能
    redirect_to user_path(current_user.id), danger: 'あなたに権限はありません' if @post.user_id != current_user.id
  end

  def update
    @post = Post.find(params[:id])
    if @post.update(post_params)
      redirect_to user_path(current_user.id), success: '変更が完了しました'
    else
      flash.now[:danger] = '変更に失敗しました'
      render :edit
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

  def map_params
    params.require(:map).permit(:post_id, :address)
  end

  def post_params
    params.require(:post).permit(:title, :description, :image, :city, :prefecture_id, :rate)
  end
end
