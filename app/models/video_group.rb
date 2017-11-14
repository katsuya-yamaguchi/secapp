class VideoGroup < ApplicationRecord
  validates :uq_group_name, presence: true, uniqueness: true
  validates :fk_category_id, presence: true
end
