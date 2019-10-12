# frozen_string_literal: true

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  add_flash_types :success, :info, :warning, :danger

  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by(id: session[:user_id])
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
end
