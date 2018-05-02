class AdminsController < ApplicationController
  before_action :sign_in_required, only: [:index]

  def index
    @nav_item_upload = "active"

    @video = Video.new

    @initial_video_title = []
    @initial_video_id = []
    @initial_video_file = []
    @initial_video_data = Video.find_by_sql(['select id, video_name, video_file_name from videos where fk_users_id = :users_id order by updated_at desc limit 10', {users_id: current_user.id}])
    if ! @initial_video_data.empty?
      for i in 0..@initial_video_data.size-1 do
        @initial_video_title.push(@initial_video_data[i]["video_name"])
        @initial_video_id.push(@initial_video_data[i]["id"])
        @initial_video_file.push(@initial_video_data[i]["video_file_name"])
      end
    end
  end

  def admin_pagination
    @addition_video_title = []
    @addition_video_id = []
    @addition_video_file = []
    content_number = request.fullpath.split("/")[2].to_i
    sql = 'select id, video_name, video_file_name from videos where fk_users_id = :users_id order by updated_at desc limit 10 offset :num'
    @additioal_video_data = Video.find_by_sql([sql, {users_id: current_user.id, num: content_number}])
    for i in 0..@additioal_video_data.size-1 do
      @addition_video_title.push(@additioal_video_data[i]["video_name"])
      @addition_video_id.push(@additioal_video_data[i]["id"])
      @addition_video_file.push(@additioal_video_data[i]["video_file_name"])
    end
    if @addition_video_title.empty? then
      render nothing: true, status: 200
      return
    end
    render layout: false
    return
  end
  
  def file_upload
    @video = Video.new(file_params)
    tag = params[:category_tag].split(",")
    @video.attributes = { fk_users_id: current_user.id, created_at: Time.new, updated_at: Time.new }
    if @video.save
      redirect_to :mypage
      @video.save_tags(tag, @video.id)
      flash[:upload_status] = "アップロードが成功しました。"
    else
      flash[:upload_status] = "アップロードが失敗しました。"
      redirect_to :mypage
    end
  end

  def file_params
   params.require(:video).permit(:video_name, :video_file_name, :description)
  end

end
