module AdminAuthorization

  def authorize_admin
    render json: { status: :denied }
  end

end
