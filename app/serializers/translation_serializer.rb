class TranslationSerializer < ActiveModel::Serializer
  attributes :priority, :rule, :target, :active

  def rule
    object.rule_config.merge({ :$type => object.rule_type })
  end

  def active
    object.rule.active?
  end
end
