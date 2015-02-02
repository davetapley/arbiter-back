module RuleType
  class Counter
    def initialize(config)
      @config = config
      @remaining = config['remaining'].to_i
    end

    def active?(_request)
      @remaining > 0
    end

    def followed(translation)
      @remaining -= 1
      @config = { 'remaining' => @remaining }
    end
  end
end

