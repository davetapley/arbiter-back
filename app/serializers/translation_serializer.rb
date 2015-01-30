class TranslationSerializer < ActiveModel::Serializer
  attributes :priority, :rule, :target

  def rule
    object.rule_config.merge({ :$type => object.rule_type })
  end
end
