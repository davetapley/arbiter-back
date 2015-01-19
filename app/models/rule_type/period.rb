module RuleType
  class Period
    attr_reader :config

    def initialize(config)
      @config = config
      @period = config['first'].to_i .. config['last'].to_i
    end

    def active?
      @period.include? Time.now.to_i
    end

  end
end
