class DeleteColumnToVideo20180306 < ActiveRecord::Migration[5.0]
  def change
    remove_column :videos, :fk_groups_id, 'BIGINT'
    remove_column :videos, :uq_video_perm, 'VARCHAR(255)'
  end
end
