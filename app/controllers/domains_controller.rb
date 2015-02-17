class DomainsController < ApplicationController
  before_action :authenticate_user!

  def index
    default = [request.env["HTTP_HOST"]]
    user = current_user.ownerships.pluck('distinct domain_id')

    domains =
      default.map { |d| { id: d, type: :default } } +
      user.map { |d| { id: d, type: :user } }

    render json: { domains: domains }
  end
end
