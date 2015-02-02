class Token < ActiveRecord::Base
  include ActiveModel::SerializerSupport

  self.primary_key = :id

  has_and_belongs_to_many :users

  has_many :translations, foreign_key: :token
end
