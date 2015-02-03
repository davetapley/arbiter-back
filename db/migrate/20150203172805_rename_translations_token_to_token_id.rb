class RenameTranslationsTokenToTokenId < ActiveRecord::Migration
  def change
    rename_column :translations, :token, :token_id
  end
end
