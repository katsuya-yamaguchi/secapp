class AddColumnToVideo20180312 < ActiveRecord::Migration[5.0]
  def change
    add_column :videos, :description, 'TEXT'
    remove_column :videos, :video_time, 'TIME'
  end
end
