class Video < ApplicationRecord
  has_many :group_maps, class_name: "GroupMap"
  has_many :video_groups, class_name: "VideoGroup", through: :group_maps
  mount_uploader :video_file_name, VideoUploader
  
  VALID_VIDEO_REGEX = /.*\.mp4/
  validates :video_file_name, presence: true, format: {with: VALID_VIDEO_REGEX}
  validates :video_name, presence: true


  def self.pagination(offset_times, sql, search_word)
    addition_video_title = []
    addition_video_data = Video.find_by_sql([sql, {num: offset_times, word: search_word}])
    for i in 0..addition_video_data.size-1 do
      addition_video_title.push(addition_video_data[i]["uq_video_name"])
    end
    return addition_video_title
  end

  def save_tags(tags)
    current_tags = VideoGroup.pluck(:uq_group_name)
    new_tags = tags - current_tags

    unless new_tags.empty?
      new_tags.each do |new_name|
        video_group = self.video_groups.new(uq_group_name: new_name, created_at: Time.new, updated_at: Time.new)
        if video_group.save
        else
          @error_msg = video_group.errors.full_messages
        end
      end
    end
  end

end
