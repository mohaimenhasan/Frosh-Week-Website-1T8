require 'google/api_client'

class OauthController < ApplicationController

  include AdminAuthorization
  after_filter :save_session

  def callback
    user_credentials.code = params[:code] if params[:code]
    user_credentials.fetch_access_token!

    redirect_to ('//' + Rails.application.config.hostname + '/admin')
  end

end
