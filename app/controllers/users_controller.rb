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
      session[:user_id] = @user.id
      redirect_to root_path, success: '登録が完了しました'
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end

  def show
    @user = User.find(params[:id])
    @posts = Post.where(user_id: params[:id])
    @user_posts = @posts.page(params[:page]).per(PER).order(created_at: :desc)
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = current_user
    @user.name = user_params[:name]
    @user.introduction = user_params[:introduction]
    @user.image = user_params[:image]
    if @user.save
      redirect_to user_path, success: '変更が完了しました'
    else
      flash.now[:danger] = '変更に失敗しました'
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password,
                                 :password_confirmation, :image, :introduction)
  end
end
