require "streamio-ffmpeg"

class Video < ApplicationRecord
  has_many :group_maps, class_name: "GroupMap"
  has_many :likes, class_name: "Like", dependent: :destroy
  has_many :video_groups, class_name: "VideoGroup", through: :group_maps
  mount_uploader :video_file_name, VideoUploader
  
  VALID_VIDEO_REGEX = /.*\.mp4/
  validates :video_file_name, presence: true, format: {with: VALID_VIDEO_REGEX}
  validates :video_name, presence: true

  def self.pagination(offset_times, sql, search_word)
    addition_video_id = []
    addition_video_title = []
    addition_video_data = Video.find_by_sql([sql, {num: offset_times, word: search_word}])
    for i in 0..addition_video_data.size-1 do
      if addition_video_data[i].nil? then
        break
      end
      addition_video_id.push(addition_video_data[i]["id"])
      addition_video_title.push(addition_video_data[i]["video_name"])
    end
    return addition_video_id, addition_video_title
  end

  def save_tags(tags, video_id)
    current_tags = VideoGroup.pluck(:uq_group_name)
    new_tags = tags - current_tags

    group = VideoGroup.select("id").where(uq_group_name: tags)
    unless group[0].nil?
      self.group_maps.create(video_group_id: group[0]["id"], video_id: video_id, created_at: Time.new, updated_at: Time.new)
    end

    unless new_tags.empty?
      new_tags.each do |new_name|
        video_group = self.video_groups.new(uq_group_name: new_name, created_at: Time.new, updated_at: Time.new)
        if video_group.save
          self.group_maps.create(video_group_id: video_group.id, video_id: video_id, created_at: Time.new, updated_at: Time.new)
        else
          @error_msg = video_group.errors.full_messages
        end
      end
    end
  end

  def like_by(user_id)
    likes.find_by(user_id: user_id)
  end

  def get_likes_number(video_id)
    likes.where(video_id: video_id).size
  end

end
