module AdminAuthorization

  def authorize_admin
    render json: { status: :denied } and return unless !get_admin.blank?
  end

  def user_credentials
    # Build a per-request oauth credential based on token stored in session
    # which allows us to use a shared API client.
    @authorization ||= (
      auth = Rails.application.config.google_api_client.authorization.dup
      auth.redirect_uri = (Rails.env.development? ? 'http://' : 'https://') + Rails.application.config.hostname + '/auth'
      auth.update_token!(session)
      auth.fetch_access_token! if auth.refresh_token && auth.expired?
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
    if Rails.application.config.offline_mode
      verified_email = true
      email = "offline_admin"
    else
      result = google_api_client.execute({
        api_method: oauth2_api.userinfo.get,
        authorization: user_credentials
      })
      data = result.data
      verified_email = data.verified_email
      email = data.email
    end
    if verified_email
      admins = ::Admin.where(email: email)
      if !admins.blank? && admins.count == 1
        admins.first
      else
        nil
      end
    else
      nil
    end
  end

  def google_api_client
    Rails.application.config.google_api_client
  end

  def oauth2_api
    Rails.application.config.oauth2_api
  end

end
