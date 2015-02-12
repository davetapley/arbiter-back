class TokensController < ApplicationController
  before_action :authenticate_user!, except: [:resolve]
  before_action :ensure_always_rule, only: [:create, :update]

  def index
    render json: current_user.tokens
  end

  def show
    render json: current_user.tokens.find(params[:id])
  end

  def create
    token_id = params[:token][:id]
    head 409 and return if Token.exists? token_id

    current_user.ownerships.create token_id: token_id

    token_params[:translations].each_with_index do |translation_params, index|
      Translation.create translation_params.merge(token_id: token_id, priority: index)
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
    host = request.env["HTTP_HOST"]

    token = Token.find params[:id]
    target = token.first_active_translation request
    fail 'no active target' if target.nil?

    redirect_to "http://#{ target }?from_host=#{ host }"
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
