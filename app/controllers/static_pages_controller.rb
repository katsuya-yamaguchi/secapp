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

  def list
    @request_courses_name = request.fullpath.split("/")[2]
    @video_category_id = VideoCategory.find_by_sql(['SELECT id FROM video_categories WHERE uq_category_name = ?', @request_courses_name.upcase])
    @video_group_id = []
    @video_group_name = []

    VideoGroup.where(id: @video_category_id).find_each do |vg|
      @video_group_id.push(vg.id)
      @video_group_name.push(vg.uq_group_name)
    end
  end

  def list_video
    @request_group_id = request.fullpath.split("/")[2]
    @video_group_name = VideoGroup.where(id: @request_group_id)[0].attributes
    @video_id = []
    @video_name = []
    @video_time = []
    Video.where(fk_groups_id: @request_group_id).find_each do |vd|
      @video_id.push(vd.id)
      @video_name.push(vd.uq_video_name)
      @video_time.push(vd.video_time.strftime("%H:%M:%S"))
    end
  end

end
