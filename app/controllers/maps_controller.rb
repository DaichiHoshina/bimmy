# frozen_string_literal: true

class MapsController < ApplicationController
  def index
    @maps = Map.all
  end

  def show
    @map = Map.find_by(post_id: params[:post_id])
  end

  def new
    @map = Map.new
  end

  def create
    # mapが空ならcreate、あればupdateアクションを呼び出す
    post = Post.find_by(id: params[:post_id])
    if post.map.nil?
      @map = Map.new
      @map.post_id = params[:post_id]

      # 県名+市町村名を@mapに入れる
      @address = Post.find_by(id: params[:post_id])

      # 市町村名があれば、県名と連結してmapに渡す
      @map.address = if !@address.city.nil?
                       @address.prefecture.name + @address.city
                     else
                       @address.prefecture.name
                     end

      redirect_to post_map_path if @map.save
    else
      redirect_to post_map_path(post_id: post.id), method: 'put'
    end
  end

  def update
    @map = Map.find_by(post_id: params[:post_id])

    # 県名+市町村名を@mapに入れる
    @address = Post.find_by(id: params[:post_id])

    if @map.update(address: @address.prefecture.name + @address.city)
      redirect_to post_map_path
    else
      flash.now[:danger] = '地図の登録に失敗しました'
    end
  end

  private

  def set_map
    @map = Map.find(params[:id])
  end

  def set_topic
    @topic = Topic.find_by(id: params[:topic_id])
  end

  def map_params
    params.require(:map).permit(:address, :latitude, :longitude, :post_id)
  end
end
