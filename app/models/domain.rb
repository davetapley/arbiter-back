class Domain
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
end
