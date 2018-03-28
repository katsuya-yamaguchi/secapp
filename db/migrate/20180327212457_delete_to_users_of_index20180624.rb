class DeleteToUsersOfIndex20180624 < ActiveRecord::Migration[5.0]
  def change
    remove_index :users, column: :email, name: :index_users_on_email
  end
end
