class CreateLikes < ActiveRecord::Migration[5.0]
  def change
    create_table :likes, id: false do |t|
      t.column :id, 'BIGSERIAL PRIMARY KEY'
      t.column :user_id, 'BIGINT NOT NULL'
      t.column :video_id, 'BIGINT NOT NULL'

      t.timestamps
    end
    add_foreign_key :likes, :users, column: :user_id, primary_key: :id
    add_foreign_key :likes, :videos, column: :video_id, primary_key: :id
  end
end
