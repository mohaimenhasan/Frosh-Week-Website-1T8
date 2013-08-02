module AdminAuthorization

  def authorize_admin
    render json: { status: :denied } and return unless Rails.env.development?
  end

  def user_credentials
    # Build a per-request oauth credential based on token stored in session
    # which allows us to use a shared API client.
    @authorization ||= (
      auth = Rails.application.config.google_api_client.authorization.dup
      auth.redirect_uri = (Rails.env.development? ? 'http://' : 'https://') + Rails.application.config.hostname + '/auth'
      auth.update_token!(session)
      auth
    )
  end

  def save_session
    # Serialize the access/refresh token to the session
    session[:access_token] = user_credentials.access_token
    session[:refresh_token] = user_credentials.refresh_token
    session[:expires_in] = user_credentials.expires_in
    session[:issued_at] = user_credentials.issued_at
  end

  def get_admin
    result = Rails.application.config.google_api_client.execute({
      :api_method => Rails.application.config.oauth_discovered_api.userinfo.get,
      :authorization => user_credentials
    })
    data = result.data
    if data.verified_email
      ::Admin.where(email: data.email)
    else
      nil
    end
  end

end
