class TokensController < ApplicationController
  before_action :authenticate_user!

  def index
    render json: Token.all
  end

  def show
    render json: Token.find(params[:id])
  end

  def update
    params[:token][:translations].each_with_index do |translation_params, index|
      translation_params = translation_params.to_hash

      translation = Translation.find_or_initialize_by token: params[:id], priority: index
      translation.update_attributes! translation_params.merge(priority: index)
    end
  end

  private

  def token_params
    params.require(:token).permit.tap do |white_listed|
      white_listed[:translations] = params[:token][:translations]
    end
  end
end
