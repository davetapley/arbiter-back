module RuleType
  class Always
    def self.from_config(_config)
      new
    end

    def active?
      true
    end
  end
end
