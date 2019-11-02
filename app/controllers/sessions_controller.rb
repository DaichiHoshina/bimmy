# frozen_string_literal: true

class SessionsController < ApplicationController
  def new; end

  def twitter
    user = User.find_or_create_from_auth(request.env['omniauth.auth'])
    current_user = user
    log_in user
    binding.pry
    redirect_to root_path, success: 'ログインに成功しました'
  end

  def create
    user = User.find_by(email: session_params[:email])
    if user&.authenticate(session_params[:password])
      log_in user
      redirect_to root_path, success: 'ログインに成功しました'
    else
      flash.now[:danger] = 'ログインに失敗しました'
      render :new
    end
  end

  def destroy
    log_out
    redirect_to root_url, info: 'ログアウトしました'
  end

  private

  def log_in(user)
    remember_token = User.new_remember_token
    cookies.permanent[:user_remember_token] = remember_token
    user.update!(remember_token: User.encrypt(remember_token))
    @current_user = user
  end

  def log_out
    cookies.delete(:user_remember_token)
  end

  def session_params
    params.require(:session).permit(:email, :password)
  end
end
