class AddDomainToTranslationIndex < ActiveRecord::Migration
  def up
    remove_index :translations, [:path_id, :priority]
    add_index :translations, [:domain_id, :path_id, :priority], unique: true
  end

  def down
    remove_index :translations, [:domain_id, :path_id, :priority]
    add_index :translations, [:path_id, :priority], unique: true
  end
end
