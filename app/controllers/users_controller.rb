# frozen_string_literal: true

PER = 5

class UsersController < ApplicationController
  before_action :authenticate_user, only: %i[show edit update]
  before_action :ensure_correct_user, only: %i[update edit]

  def index
    @users = User.all
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      redirect_to root_path, success: '登録が完了しました'
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: params[:id]).includes(:user, :likes, :like_users)
    @user_posts = @posts.page(params[:page]).per(PER).order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find_by(id: current_user.id)
    if @user.update(user_params)
      redirect_to user_path, success: '変更が完了しました'
    else
      flash.now[:danger] = '変更に失敗しました'
      render :edit
    end
  end

  def destroy
    @user = User.find_by(id: params[:id])
    @post = Post.where(user_id: params[:id])

    # 管理人のみが削除可能
    if current_user.id == 1
      if @user.destroy
        @post.delete_all
        redirect_to root_path, success: 'ユーザーを削除しました'
      else
        flash.now[:danger] = 'ユーザーの削除に失敗しました'
        render :edit
      end
    else
      redirect_to user_path(current_user.id), danger: 'あなたに権限はありません'
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :image, :introduction)
  end

  def log_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:user_remember_token] = remember_token
    user.update!(remember_token: User.encrypt(remember_token))
    @current_user = user
  end
end
