class CreateVideos < ActiveRecord::Migration[5.0]
  def change
    create_table :videos, id: false do |t|
      t.column :id, 'BIGSERIAL PRIMARY KEY'
      t.column :video_time, 'TIME NOT NULL'
      t.column :uq_video_name, 'VARCHAR(255)'
      t.column :fk_groups_id, 'BIGINT NOT NULL'
      #t.column :fk_item_id, 'BIGINT NOT NULL'
      t.integer :delete_flag, default: '0', null:false
      t.column :num_play, 'BIGINT NOT NULL DEFAULT 0'
      t.column :video, 'VARCHAR(255)'
      t.column :description, 'VARCHAR(255)'
      t.column :procedure, 'VARCHAR(255)'

      t.timestamps
    end
    add_index :videos, [:uq_video_name], unique: true
    add_index :videos, [:video], unique: true
    add_index :videos, [:description], unique: true
    add_index :videos, [:procedure], unique: true
    add_foreign_key :videos, :video_groups, column: :fk_groups_id, primary_key: :id
  end
end
