# frozen_string_literal: true

class RankingsController < ApplicationController
  def index
    @likes = Post.all
    @likes_ranking = @likes.page(params[:page]).per(PER).order(created_at: :desc)
  end
end
