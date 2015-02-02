class Translation < ActiveRecord::Base
  self.primary_keys = :token, :priority

  def self.for_token(token, request)
    translations = where(token: token).order(:priority)
    translations.each do |t|
      if t.rule.active? request
        t.followed!
        return t.target
      end
    end

    nil
  end

  def rule_json
    read_attribute :rule
  end

  def rule_type
    rule_json['$type']
  end

  def rule_config
    rule_json.except '$type'
  end

  def rule
    "RuleType::#{ rule_type }".constantize.new rule_config
  end

  def followed!
    if rule.respond_to? :followed
      new_rule_config = rule.followed self
      update_attribute :rule, new_rule_config.merge('$type' => rule_type)
    end
  end
end
