# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  add_flash_types :success, :info, :warning, :danger

  helper_method :current_user, :logged_in?

  def current_user
    remember_token = User.encrypt(cookies[:user_remember_token])
    @current_user ||= User.find_by(remember_token: remember_token)
  end

  def logged_in?
    !current_user.nil?
  end

  def authenticate_user
    redirect_to login_path, danger: 'ログインしてください' if current_user.nil?
  end

  def ensure_correct_user
    redirect_to login_path, danger: '権限がありません' if params[:id].to_i != current_user.id
  end

  private

  def authenticate
    return if logged_in?

    redirect_to root_path, alert: 'ログインしてください'
  end
end
