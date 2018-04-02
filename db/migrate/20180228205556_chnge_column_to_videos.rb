class ChngeColumnToVideos < ActiveRecord::Migration[5.0]
  def change
    change_column :videos, :fk_users_id, 'BIGINT', null: false
  end
end
