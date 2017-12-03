class ChangeColumnToVideo < ActiveRecord::Migration[5.0]
  def change
    change_column :video_groups, :uq_group_perm, 'VARCHAR(255)', null: false
    change_column :videos, :uq_video_perm, 'VARCHAR(255)', null: false
  end
end
