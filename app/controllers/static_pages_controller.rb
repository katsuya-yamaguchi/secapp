class StaticPagesController < ApplicationController
  before_action :sign_in_required, only: [:mypage]

  @@search_word = String.new

  def index
    @initial_video_title = []
    initial_video_data = Video.find_by_sql(['select id, video_name from videos order by updated_at desc limit 10'])
    for i in 0..9 do
      @initial_video_title.push(initial_video_data[i]["video_name"])
    end
  end

  def index_pagination
    @addition_video_title = []
    content_number = request.fullpath.split("/")[2].to_i
    sql = 'select id, video_name from videos order by updated_at desc limit 10 offset :num'
    additioal_video_data = Video.find_by_sql([sql, {num: content_number}])
    for i in 0..additioal_video_data.size-1 do
      @addition_video_title.push(additioal_video_data[i]["video_name"])
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
    type = request.fullpath.split("/")[1].to_s
    offset_times = request.fullpath.split("/")[2].to_i
    if type == "keyword" then
      sql = 'select id, video_name from videos where video_name like :word order by updated_at desc offset :num limit 10'
    else
      sql = 'select id, video_name from videos where fk_groups_id = (select id from video_groups where uq_group_name like :word) order by updated_at desc offset :num limit 10'
    end
    @addition_video_title = Video.pagination(offset_times, sql, @@search_word)
    if @addition_video_title.empty? then
      render nothing: true, status: 200
      return
    end
    render layout: false
    return
  end

  def search
    @initial_video_title = []
    @nav_item_keyword = "active"
    if params[:category_tag] then
      if params[:search_type] == "search_field_keyword" then
        sql = 'select id, video_name from videos where video_name like :word order by updated_at desc limit 10'
        @nav_item_keyword = "active"
      else
        sql = 'select id, video_name from videos where fk_groups_id = (select id from video_groups where uq_group_name like :word) order by updated_at desc limit 10;'
        @nav_item_keyword = ""
        @nav_item_tag = "active"
      end
      @@search_word = '%' + params[:category_tag] + '%'
      initial_video_data = Video.find_by_sql([sql, {word: @@search_word}])
      for i in 0..9 do
        if initial_video_data[i].nil? then
          break
        end
        @initial_video_title.push(initial_video_data[i]["video_name"])
      end
    end
  end

  def mypage
    @initial_video_title = []
    @nav_item_upload = "active"

    if !user_signed_in?
      redirect_to root_path
    end
    @video = Video.new

    @initial_video_title = []
    initial_video_data = Video.find_by_sql(['select id, video_name from videos where fk_users_id = :users_id order by updated_at desc limit 10', {users_id: current_user.id}])
    for i in 0..9 do
      @initial_video_title.push(initial_video_data[i]["video_name"])
    end
  end

  def mypage_pagination
    @addition_video_title = []
    content_number = request.fullpath.split("/")[2].to_i
    sql = 'select id, video_name from videos where fk_users_id = :users_id order by updated_at desc limit 10 offset :num'
    p current_user.id
    additioal_video_data = Video.find_by_sql([sql, {users_id: current_user.id, num: content_number}])
    for i in 0..additioal_video_data.size-1 do
      @addition_video_title.push(additioal_video_data[i]["video_name"])
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
      @video.save_tags(tag)
      flash[:upload_status] = "アップロードが成功しました。"
    else
      flash[:upload_status] = "アップロードが失敗しました。"
      render :mypage
    end
  end

  def file_params
   params.require(:video).permit(:video_name, :video_file_name, :description)
  end

  def riyokiyaku
  end

  def courses
    @courses_id_name = {}
    @courses_id_name_length = 0

    VideoCategory.find_each do |vc|
      @courses_id_name.store(vc.id,vc.uq_category_name)
      @courses_id_name_length = @courses_id_name.length
    end
  end

  def list_courses
    @request_courses_name = request.fullpath.split("/")[2]
    @video_category_id = VideoCategory.find_by_sql(['SELECT id FROM video_categories WHERE uq_category_name = ?', @request_courses_name.upcase])
    @video_group_id = []
    @video_group_name = []

    VideoGroup.where(id: @video_category_id).find_each do |vg|
      @video_group_id.push(vg.id)
      @video_group_name.push(vg.uq_group_name)
    end
  end

  def list_videos
    @request_category_perm = request.fullpath.split("/")[2].upcase
    use_category_name_to_id = VideoCategory.select("id").where(uq_category_name: @request_category_perm)
    @video_group_name = VideoGroup.select("uq_group_name").where(fk_category_id: use_category_name_to_id)[0].attributes
    use_group_name_to_id = VideoGroup.select("id").where(uq_group_name: @video_group_name["uq_group_name"])

    @video_id = []
    @video_name = []
    @video_time = []
    @video_perm = []
    Video.where(fk_groups_id: use_group_name_to_id).find_each do |vd|
      @video_id.push(vd.id)
      @video_name.push(vd.video_name)
      @video_time.push(vd.video_time.strftime("%H:%M:%S"))
      @video_perm.push(vd.uq_video_perm)
    end
  end

  def videos
    @list_video_name = []
    @list_video_file = []
    @list_video_desc = []
    @list_video_proc = []
    @list_video_perm = []
    @request_group_perm = request.fullpath.split("/")[2]
    @request_video_perm = request.fullpath.split("/")[4]
    @active_video_item = Video.select("fk_groups_id, video_file_name, description, procedure, video_name").where(uq_video_perm: @request_video_perm)[0].attributes
    Video.select("id, video_name, video_file_name, description, procedure, uq_video_perm").where(fk_groups_id: @active_video_item["fk_groups_id"]).where.not(video_name: @active_video_item["video_name"]).order("id").find_each do |vd|
      @list_video_name.push(vd.video_name)
      @list_video_file.push(vd.video_file_name.to_param.split("/")[3])
      pp vd.video_file_name.to_param.split("/")[3]
      @list_video_desc.push(vd.description)
      @list_video_proc.push(vd.procedure)
      @list_video_perm.push(vd.uq_video_perm)
    end
  end

  def index_test
  end

end
