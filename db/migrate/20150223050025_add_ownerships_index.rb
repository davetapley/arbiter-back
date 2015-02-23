class AddOwnershipsIndex < ActiveRecord::Migration
  def change
    add_index :ownerships, [:user_id, :domain_id, :path_id], unique: true
  end
end
