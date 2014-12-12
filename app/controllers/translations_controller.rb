class TranslationsController < ApplicationController
  def resolve
    target = Translation.for_token params[:id]
    fail 'no active target' if target.nil?

    redirect_to "http://#{ target }"
  end
end
