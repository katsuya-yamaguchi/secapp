class AddToUser20180323 < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :provider, :string
    add_column :users, :uid, :string
    add_column :users, :username, :string, default: "anoymous"
  end
end