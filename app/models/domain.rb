class Domain
  def initialize(domain)
    @domain = domain
  end

  def save
    heroku = PlatformAPI.connect_oauth ENV['PLATFORM_API_TOKEN']
    heroku.domain.create(ENV['PLATFORM_API_APP_NAM'], { hostname: @domain })
  rescue Excon::Errors::UnprocessableEntity => e
    error = JSON.parse e.response.body
    unless error['message'] == 'Domain already added to this app.'
      raise e
    end
  end
end
