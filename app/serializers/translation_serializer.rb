class TranslationSerializer < ActiveModel::Serializer
  attributes :priority, :rule, :target, :active

  def rule
    object.rule_config.merge({ :$type => rule_type })
  end

  def rule_type
    "#{ object.rule_type }Rule"
  end

  def active
    object.rule.active?
  end
end
