class Video < ApplicationRecord
  mount_uploader :video_file_name, VideoUploader
  mount_uploader :description, DescriptionUploader
  mount_uploader :procedure, ProcedureUploader
  
  VALID_TIME_REGEX = /[0123456789]{2}:[0123456789]{2}:[0123456789]{2}/
  validates :video_time, presence: true, format: {with: VALID_TIME_REGEX}
  validates :uq_video_name, presence: true, uniqueness: true
  validates :fk_groups_id, presence: true

end
