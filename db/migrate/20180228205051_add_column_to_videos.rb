class AddColumnToVideos < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :fk_users_id, 'BIGINT'
    add_foreign_key :videos, :users, column: :fk_users_id, primary_key: :id
  end
end
