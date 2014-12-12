class TranslationSerializer < ActiveModel::Serializer
  attributes :token, :priority, :rule_type, :rule_config, :target, :active

  def active
    object.rule.active?
  end
end
