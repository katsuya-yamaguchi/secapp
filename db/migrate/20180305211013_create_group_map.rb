class CreateGroupMap < ActiveRecord::Migration[5.0]
  def change
    create_table :group_maps, id: false do |t|
      t.column :id, 'BIGSERIAL PRIMARY KEY'
      t.column :fk_video_groups_id, 'BIGINT'
      t.column :fk_videos_id, 'BIGINT'
      t.timestamps
    end
    add_foreign_key :group_maps, :video_groups, column: :fk_video_groups_id, primary_key: :id
    add_foreign_key :group_maps, :videos, column: :fk_videos_id, primary_key: :id
  end
end
