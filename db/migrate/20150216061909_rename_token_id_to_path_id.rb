class RenameTokenIdToPathId < ActiveRecord::Migration
  def change
    rename_column :ownerships, :token_id, :path_id
    rename_column :translations, :token_id, :path_id
    rename_column :tokens, :token_id, :path_id
  end
end
