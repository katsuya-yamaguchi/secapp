class VideoGroup < ApplicationRecord
  has_many :group_maps, class_name: "VideoGroup"
  has_many :videos, class_name: "Video", through: :group_maps
  validates :uq_group_name, presence: true, uniqueness: true
end
