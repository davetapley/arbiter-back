class CreateTokensView < ActiveRecord::Migration
  def up
    execute 'CREATE VIEW tokens AS SELECT DISTINCT token AS id FROM translations;'
  end

  def down
    execute 'DROP VIEW tokens;'
  end
end
