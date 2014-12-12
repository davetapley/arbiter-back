class TokenSerializer < ActiveModel::Serializer
  has_many :translations, serializer: TranslationSerializer

  attributes :id, :translations
end
