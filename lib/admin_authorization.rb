module AdminAuthorization

  def authorize_admin
    render json: { status: :denied } and return unless Rails.env.development?
  end

end
