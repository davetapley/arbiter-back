class RemoveOwnershipsId < ActiveRecord::Migration
  def change
    remove_column :ownerships, :id
  end
end
