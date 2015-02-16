class Translation < ActiveRecord::Base
  belongs_to :token, primary_key: :path_id

  self.primary_keys = :domain_id, :path_id, :priority

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
