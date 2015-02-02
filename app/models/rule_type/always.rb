module RuleType
  class Always
    def initialize(_config)
    end

    def active?(_request)
      true
    end
  end
end
