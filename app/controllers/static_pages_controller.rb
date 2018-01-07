class StaticPagesController < ApplicationController
  def index
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
      @video_name.push(vd.uq_video_name)
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
    @active_video_item = Video.select("fk_groups_id, video_file_name, description, procedure, uq_video_name").where(uq_video_perm: @request_video_perm)[0].attributes
    Video.select("id, uq_video_name, video_file_name, description, procedure, uq_video_perm").where(fk_groups_id: @active_video_item["fk_groups_id"]).where.not(uq_video_name: @active_video_item["uq_video_name"]).order("id").find_each do |vd|
      @list_video_name.push(vd.uq_video_name)
      @list_video_file.push(vd.video_file_name.to_param.split("/")[3])
      pp vd.video_file_name.to_param.split("/")[3]
      @list_video_desc.push(vd.description)
      @list_video_proc.push(vd.procedure)
      @list_video_perm.push(vd.uq_video_perm)
    end
  end

end
