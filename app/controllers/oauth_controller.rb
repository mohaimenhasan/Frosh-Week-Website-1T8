require 'google/api_client'

class OauthController < ApplicationController

  include AdminAuthorization
  after_filter :save_session

  def callback
    unless params.has_key? :error
      user_credentials.code = params[:code] if params[:code]
      user_credentials.fetch_access_token!
    end

    redirect_to (Rails.application.config.hostname + '/admin')
  end

end
