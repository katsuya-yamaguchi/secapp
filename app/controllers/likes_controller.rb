class LikesController < ApplicationController
  before_action :set_variable

  def create
    @like = Like.create(user_id: current_user.id, video_id: params[:video_id])
    #@video = Video.where(id: params[:video_id])[0]
  end

  def destroy
    like = Like.find_by(user_id: current_user.id, video_id: params[:video_id])
    like.destroy
    #@video = Video.where(id: params[:video_id])[0]
  end

  def set_variable
    @video = Video.where(id: params[:video_id])[0]
    @video_id = @video.id
  end
end
