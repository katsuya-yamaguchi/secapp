class Video < ApplicationRecord
  mount_uploader :video_file_name, VideoUploader
  mount_uploader :description, DescriptionUploader
  mount_uploader :procedure, ProcedureUploader
  
  VALID_TIME_REGEX = /[0123456789]{2}:[0123456789]{2}:[0123456789]{2}/
  validates :video_time, presence: true, format: {with: VALID_TIME_REGEX}
  validates :uq_video_name, presence: true, uniqueness: true
  validates :fk_groups_id, presence: true

  def self.pagination(offset_times, sql, search_word)
    addition_video_title = []
    addition_video_data = Video.find_by_sql([sql, {num: offset_times, word: search_word}])
    for i in 0..addition_video_data.size-1 do
      addition_video_title.push(addition_video_data[i]["uq_video_name"])
    end
    return addition_video_title
  end

end
