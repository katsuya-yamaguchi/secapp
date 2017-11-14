class CreateVideoCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :video_categories, id: false do |t|
      t.column :id, 'BIGSERIAL PRIMARY KEY'
      t.column :uq_category_name, 'VARCHAR(255)'
      t.integer :delete_flag, default: '0', null:false

      t.timestamps
    end
    add_index :video_categories, [:uq_category_name], unique: true
  end
end
