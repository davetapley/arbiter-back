class Translation < ActiveRecord::Base
  self.primary_keys = :token, :priority

  def self.for_token(token)
    translations = where(token: token).order(:priority)
    translations.each do |t|
      return t.target if t.rule.active?
    end

    nil
  end

  def rule_json
    read_attribute :rule
  end

  def rule_type
    rule_json['type']
  end

  def rule_config
    rule_json.except 'type'
  end

  def rule
    "RuleType::#{ rule_type }".constantize.new rule_config
  end
end
