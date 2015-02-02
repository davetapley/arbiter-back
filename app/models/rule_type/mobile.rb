module RuleType
  class Mobile
    attr_reader :config

    def initialize(_config)
    end

    def active?(request)
      Browser.new(ua: request.user_agent).mobile?
    end
  end
end
