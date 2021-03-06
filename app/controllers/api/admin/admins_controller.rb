require 'awesome_print' if Rails.env.development?

class Api::Admin::AdminsController < Api::AdminsController

  include AdminAuthorization
  before_filter :authorize_admin

  def index
    render json: {
      admins: [get_admin]
    }
  end

end
