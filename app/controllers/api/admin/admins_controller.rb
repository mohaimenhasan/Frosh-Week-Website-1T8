require 'awesome_print' if Rails.env.development?

class Api::Admin::AdminsController < Api::Admin::ApplicationController

  def index
    render json: {
      admins: get_admin
    }
  end

end
