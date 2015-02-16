class AddDomainToTokenView < ActiveRecord::Migration
  def up
    execute 'DROP VIEW tokens;'
    execute 'CREATE VIEW tokens AS SELECT DISTINCT domain_id, token_id FROM translations;'
  end

  def down
    execute 'DROP VIEW tokens;'
    execute 'CREATE VIEW tokens AS SELECT DISTINCT token AS id FROM translations;'
  end
end
