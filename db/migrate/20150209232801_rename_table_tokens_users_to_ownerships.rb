class RenameTableTokensUsersToOwnerships < ActiveRecord::Migration
  def change
    rename_table :tokens_users, :ownerships
  end
end
