module RuleType
  class Period
    def self.from_config(config)
      new config['first'], config['last']
    end

    def initialize(first, last)
      @period = first.to_i..last.to_i
    end

    def active?
      @period.include? Time.now.to_i
    end

    def config
      { first: @period.first, last: @period.last }
    end
  end
end
