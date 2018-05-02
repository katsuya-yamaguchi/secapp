class StaticPagesController < ApplicationController
  before_action :sign_in_required, only: [:mypage, :delete_user]

  @@search_word = String.new

  def index
  end

  def home 
    @initial_video_title = []
    @initial_video_id = []
    @initial_video_file = []
    @initial_video_data = Video.find_by_sql(['select id, video_name, video_file_name from videos order by updated_at desc limit 10'])
    if !@initial_video_data.empty?
      for i in 0..9 do
        if @initial_video_data[i].nil?
          break
        end
        @initial_video_id.push(@initial_video_data[i]["id"])
        @initial_video_title.push(@initial_video_data[i]["video_name"])
        @initial_video_file.push(@initial_video_data[i]["video_file_name"])
      end
    end
  end

  def home_pagination
    @addition_video_title = []
    @addition_video_id = []
    @addition_video_file = []
    content_number = request.fullpath.split("/")[2].to_i
    sql = 'select id, video_name, video_file_name from videos order by updated_at desc limit 10 offset :num'
    @additioal_video_data = Video.find_by_sql([sql, {num: content_number}])
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
  
  def pagination
    @addition_video_title = []
    @addition_video_id = []
    @addition_video_file = []
    type = request.fullpath.split("/")[1].to_s
    offset_times = request.fullpath.split("/")[2].to_i
    if type == "keyword" then
      sql = 'select id, video_name, video_file_name from videos where video_name like :word order by updated_at desc offset :num limit 10'
    else
      sql = 'select distinct vd.id, vd.video_name, vd.video_file_name from videos vd inner join group_maps gm on vd.id = gm.video_id inner join video_groups vg on gm.video_group_id = vg.id where vg.uq_group_name like :word order by vd.updated_at desc offset :num limit 10'
    end
    addition_data = Video.pagination(offset_times, sql, @@search_word)
    @addition_video_id = addition_data[0]
    @addition_video_title = addition_data[1]
    @addition_video_file = addition_data[2]
    if @addition_video_title.nil? then
      render nothing: true, status: 200
      return
    end
    render layout: false
    return
  end

  def search
    @initial_video_title = []
    @initial_video_id = []
    @initial_video_file = []
    @nav_item_keyword = "active"
    if params[:category_tag] then
      if params[:search_type] == "search_field_keyword" then
        sql = 'select id, video_name, video_file_name from videos where video_name like :word order by updated_at desc limit 10'
        @nav_item_keyword = "active"
      else
        sql = 'select distinct vd.id, vd.video_name, vd.updated_at, vd.video_file_name from videos vd inner join group_maps gm on vd.id = gm.video_id inner join video_groups vg on gm.video_group_id = vg.id where vg.uq_group_name like :word order by vd.updated_at desc limit 10'
        @nav_item_keyword = ""
        @nav_item_tag = "active"
      end
      @@search_word = '%' + params[:category_tag] + '%'
      @initial_video_data = Video.find_by_sql([sql, {word: @@search_word}])
      for i in 0..9 do
        if @initial_video_data[i].nil? then
          break
        end
        @initial_video_id.push(@initial_video_data[i]["id"])
        @initial_video_title.push(@initial_video_data[i]["video_name"])
        @initial_video_file.push(@initial_video_data[i]["video_file_name"])
      end
    end
  end

  def mypage
    @nav_item_mypage = "active"

    if !user_signed_in?
      redirect_to root_path
    end
    @video = Video.new

    @initial_video_title = []
    @initial_video_id = []
    @initial_video_file = []
    @initial_video_data = Video.find_by_sql(['select v.id, v.video_name, v.video_file_name from videos v inner join likes l on v.id = l.video_id where l.user_id = :users_id order by v.updated_at desc limit 10', {users_id: current_user.id}])
    if ! @initial_video_data.empty?
      for i in 0..@initial_video_data.size-1 do
        @initial_video_title.push(@initial_video_data[i]["video_name"])
        @initial_video_id.push(@initial_video_data[i]["id"])
        @initial_video_file.push(@initial_video_data[i]["video_file_name"])
      end
    end
  end

  def mypage_pagination
    @addition_video_title = []
    @addition_video_id = []
    @addition_video_file = []
    content_number = request.fullpath.split("/")[2].to_i
    sql = 'select v.id, v.video_name, v.video_file_name from videos v inner join likes l on v.id = l.video_id where l.user_id = :users_id order by v.updated_at desc limit 10 offset :num'
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

  def delete_user
  end

  def video
    @file = ""
    video_id = request.fullpath.split("/")[2].to_i
    sql = "select id, video_name, video_file_name, description from videos where id = :num;"
    @video_data = Video.find_by_sql([sql, {num: video_id}])
    @name = @video_data[0]["video_name"]
    @file = @video_data[0]["video_file_name"]
    @description = @video_data[0]["description"]
  end

  def video_destroy
    video = Video.new
    video.delete_file_with(params["id"])
    redirect_to mypage_path
  end

  def file_params
   params.require(:video).permit(:video_name, :video_file_name, :description)
  end

  def riyokiyaku
  end

end
