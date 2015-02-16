class AddDomains < ActiveRecord::Migration
  def change
    add_column :ownerships, :domain_id, :string
    add_column :translations, :domain_id, :string
  end
end
