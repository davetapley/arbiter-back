class Domain
  DEFAULT_DOMAINS = ENV['DEFAULT_DOMAINS'].split(',')

  def self.default
    DEFAULT_DOMAINS
  end

  def self.default_blacklist
    [/^$/, /users/, /tokens/, /domains/, /translations/]
  end

  def initialize(domain)
    @domain = domain
  end

  def save
    token = ENV['PLATFORM_API_TOKEN']
    app_name = ENV['PLATFORM_API_APP_NAME']

    return unless token && app_name

    heroku = PlatformAPI.connect_oauth token
    heroku.domain.create app_name, { hostname: @domain }
  rescue Excon::Errors::UnprocessableEntity => e
    error = JSON.parse e.response.body
    unless error['message'] == 'Domain already added to this app.'
      raise e
    end
  end

  def path_available(path_id)
    return true unless Domain.default.include? @domain
    !Domain.default_blacklist.any? do |regex|
      regex =~ path_id
    end
  end
end
