class DeleteColumnToVideo20180306 < ActiveRecord::Migration[5.0]
  def change
    remove_column :videos, :fk_groups_id
  end
end
