class CreateUsersTokensJoin < ActiveRecord::Migration
  def change
    create_table :tokens_users do |t|
      t.integer :user_id
      t.string :token_id
    end

    add_index :tokens_users, :user_id
  end
end
