class DeleteColumnToVideoGroup < ActiveRecord::Migration[5.0]
  def change
    remove_column :video_groups, :uq_group_perm
    remove_column :video_groups, :fk_category_id
  end
end
