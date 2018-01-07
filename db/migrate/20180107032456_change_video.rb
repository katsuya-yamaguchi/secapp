class ChangeVideo < ActiveRecord::Migration[5.0]
  def change
    rename_column :videos, :video, :video_file_name
  end
end
