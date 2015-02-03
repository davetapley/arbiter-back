class Token < ActiveRecord::Base
  include ActiveModel::SerializerSupport

  self.primary_key = :id

  has_and_belongs_to_many :users

  has_many :translations, foreign_key: :token_id

  def first_active_translation(request)
    translations.order(:priority).each do |t|
      if t.rule.active? request
        t.followed!
        return t.target
      end
    end

    nil
  end
end
