class TokenSerializer < ActiveModel::Serializer
  has_many :translations, serializer: TranslationSerializer

  attributes :id, :translations

  def id
    "#{ object.domain_id },#{ object.path_id }"
  end
end
