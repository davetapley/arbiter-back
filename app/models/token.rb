class Token < ActiveRecord::Base
  include ActiveModel::SerializerSupport

  self.primary_key = :domain_id, :path_id

  has_many :ownerships, foreign_key: [:domain_id, :path_id]
  has_many :users, through: :ownerships

  has_many :translations, foreign_key: [:domain_id, :path_id]

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
