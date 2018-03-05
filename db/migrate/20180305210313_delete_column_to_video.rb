class DeleteColumnToVideo < ActiveRecord::Migration[5.0]
  def change
    remove_column :videos, :description
    remove_column :videos, :procedure
  end
end
