require 'awesome_print' if Rails.env.development?

class Api::AdminsController < ApplicationController

  def index
    render json: {
      admins: []
    }
  end

end
