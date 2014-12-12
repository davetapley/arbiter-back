class Token
  include ActiveModel::SerializerSupport

  attr_reader :id

  def self.all
    Translation.uniq.pluck(:token).map { |t| new t }
  end

  def initialize(token)
    @id = token
  end

  def translations
    Translation.where token: @id
  end
end
