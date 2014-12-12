class TokensController < ApplicationController
  def index
    render json: Token.all
  end

  def show
    render json: Token.new(params[:id])
  end
end
