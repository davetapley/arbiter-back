class TokensController < ApplicationController
  before_action :authenticate_user!, except: [:resolve, :none]
  before_action :ensure_always_rule, only: [:create, :update]

  def index
    render json: current_user.tokens
  end

  def show
    domain_id, _comma, path_id = params[:id].rpartition ','
    render json: current_user.tokens.find_by!(domain_id: domain_id, path_id: path_id)
  end

  def create
    partition = params[:token][:id].rpartition ','
    domain_id = partition.first
    path_id = partition.last
    head 409 and return if Token.find_by(domain_id: domain_id, path_id: path_id).present?

    current_user.ownerships.create domain_id: domain_id, path_id: path_id

    token_params[:translations].each_with_index do |translation_params, index|
      Translation.create translation_params.merge(domain_id: domain_id, path_id: path_id, priority: index)
    end
  end

  def update
    token = current_user.tokens.find params[:id]

    token_params[:translations].each_with_index do |translation_params, index|
      translation = token.translations.find_or_initialize_by priority: index
      translation.update_attributes! translation_params.merge(priority: index)
    end
  end

  def resolve
    host = params[:host] || request.env["HTTP_HOST"]

    token = Token.find_by! domain_id: host, path_id: params[:id]
    target = token.first_active_translation request
    fail 'no active target' if target.nil?

    params[:host] ? head(:ok) : redirect_to("http://#{ target }?from_host=#{ host }")
  end

  def none
    redirect_to "//#{ Rails.application.secrets.front_end_url }"
  end

  private

  def token_params
    params.require(:token).permit!
  end

  def ensure_always_rule
    last_translation = token_params[:translations].last
    unless last_translation[:rule][:$type] == 'Always'
      json = { error: 'Lowest priority translation must have an always rule' }
      render json: json, status: :unprocessable_entity
    end
  end
end
