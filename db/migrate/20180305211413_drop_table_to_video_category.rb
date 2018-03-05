class DropTableToVideoCategory < ActiveRecord::Migration[5.0]
  def change
    drop_table :video_categories
  end
end
