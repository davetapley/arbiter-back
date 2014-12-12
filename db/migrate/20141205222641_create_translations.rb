class CreateTranslations < ActiveRecord::Migration
  def change
    create_table :translations, id: false, primary_key: [:token, :priority] do |t|

      t.string :token, uniq: true, null: false
      t.integer :priority, null: false
      t.string :rule_type, null: false
      t.json :rule_config
      t.string :target, null: false

      t.timestamps
    end

    add_index :translations, [:token, :priority], unique: true
  end
end
