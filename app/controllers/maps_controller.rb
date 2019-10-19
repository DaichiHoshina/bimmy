# frozen_string_literal: true

class MapsController < ApplicationController
  # before_action :set_map, only: %i[show edit update destroy]
  # before_action :set_topic, only: %i[index new edit create destroy]
  # GET /topics/:topic_id/maps
  # GET /maps.json
  def index
    @maps = Map.all
  end

  # GET /topics/:topic_id/maps/:id
  # GET /maps/1.json
  def show
    @map = Map.find_by(id: params[:id])
  end

  # GET /topics/:topic_id/maps/new
  def new
    @map = Map.new
  end

  # GET /topics/:topic_id/maps/:id/edit
  def edit; end

  # POST /topics/:topic_id/maps
  # POST /maps.json
  def create
    @map = Map.new(map_params)
    if @map.save
      redirect_to root_path, success: '登録が完了しました'
    else
      flash.now[:danger] = '登録に失敗しました'
      render :new
    end
  end

  # PATCH/PUT /topics/:topic_id/maps/:id
  # PATCH/PUT /maps/1.json
  def update
    respond_to do |format|
      if @map.update(map_params)
        format.html { redirect_to topic_map_path(topic_id: @map.topic_id, id: @map.id), notice: 'Map was successfully updated.' }
        format.json { render :show, status: :ok, location: topic_map_path(topic_id: @map.topic_id, id: @map.id) }
      else
        format.html { render :edit }
        format.json { render json: @map.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/:topic_id/maps/:id
  # DELETE /maps/1.json
  def destroy
    @map.destroy
    respond_to do |format|
      format.html { redirect_to topic_maps_path(topic_id: @topic.id), notice: 'Map was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_map
    @map = Map.find(params[:id])
  end

  def set_topic
    @topic = Topic.find_by(id: params[:topic_id])
  end

  def map_params
    params.require(:map).permit(:address, :latitude, :longitude, :topic_id)
  end
end
