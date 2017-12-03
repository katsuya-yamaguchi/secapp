class AdminsController < ApplicationController
  def index
    if !user_signed_in?
      redirect_to root_path
    end
    @video = Video.new
    video_group_select
  end

  def file_upload
    @video = Video.new(file_params)
    @video.attributes = { created_at: Time.new, updated_at: Time.new }
    if @video.save
      redirect_to admin_path
    else
      p @video.errors.full_messages
      video_group_select
      render :index
    end
  end

  def video_group_select
    @groups = VideoGroup.select("id, uq_group_name")
  end

  def file_params
   params.require(:video).permit(:uq_video_name, :video_time, :fk_groups_id, :video, :description, :procedure)
  end

end
