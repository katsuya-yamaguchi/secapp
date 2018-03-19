class ChangeIndexToVideos20180315 < ActiveRecord::Migration[5.0]
  def change
    remove_index :videos, column: :video_file_name, name: :index_videos_on_video_file_name
    remove_index :videos, column: :uq_video_name, name: :index_videos_on_uq_video_name
    rename_column :videos, :uq_video_name, :video_name
    rename_column :group_maps, :fk_video_groups_id, :video_group_id
    rename_column :group_maps, :fk_videos_id, :video_id
  end
end
