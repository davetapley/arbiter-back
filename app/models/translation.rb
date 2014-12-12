class Translation < ActiveRecord::Base
  self.primary_keys = :token, :priority

  def self.for_token(token)
    translations = where(token: token).order(:priority)
    translations.each do |t|
      return t.target if t.rule.active?
    end

    nil
  end

  def rule
    "RuleType::#{ rule_type }".constantize.from_config rule_config
  end
end
