class CreateVideoGroups < ActiveRecord::Migration[5.0]
  def change
    create_table :video_groups, id: false do |t|
      t.column :id, 'BIGSERIAL PRIMARY KEY'
      t.column :uq_group_name, 'VARCHAR(255) NOT NULL'
      t.column :fk_category_id, 'BIGINT'
      t.integer :delete_flag, default: '0', null:false

      t.timestamps
    end
    add_index :video_groups, [:uq_group_name], unique: true
    add_foreign_key :video_groups, :video_categories, column: :fk_category_id, primary_key: :id
  end
end
