class AddColumnToVideoGroup < ActiveRecord::Migration[5.0]
  def change
    add_column :video_groups, :uq_group_perm, 'VARCHAR(255)'
    add_index :video_groups, [:uq_group_perm], unique: true

    add_column :videos, :uq_video_perm, 'VARCHAR(255)'
    add_index :videos, [:uq_video_perm], unique: true
  end
end
