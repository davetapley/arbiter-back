class TokensController < ApplicationController
  before_action :authenticate_user!, except: [:resolve]

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
    token = Token.find params[:id]
    target = token.first_active_translation request
    fail 'no active target' if target.nil?

    redirect_to "http://#{ target }"
  end

  private

  def token_params
    params.require(:token).permit!
  end
end
