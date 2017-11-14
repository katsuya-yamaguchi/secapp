class VideoCategory < ApplicationRecord
  validates :uq_category_name, presence: true, uniqueness: true
end
