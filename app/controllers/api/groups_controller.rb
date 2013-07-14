require 'awesome_print' if Rails.env.development?

class Api::GroupsController < ActionController::Base

  def show
    render json: { user: Group.find(params[:id]) }
  end

  def index
    render json: { users: Group.all }
  end

end
