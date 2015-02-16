class Ownership < ActiveRecord::Base
  self.primary_key = :user_id, :domain_id, :path_id

  belongs_to :token, foreign_key: [:domain_id, :path_id]
  belongs_to :user
end
