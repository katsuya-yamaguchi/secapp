class VideoGroup < ApplicationRecord
  has_many :video, through: :group_map
  has_many :group_map
  validates :uq_group_name, presence: true, uniqueness: true
end
