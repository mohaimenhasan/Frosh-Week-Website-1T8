require 'awesome_print' if Rails.env.development?

class Api::GroupsController < ActionController::Base

  def show
    render json: { group: Group.find(params[:id]) }
  end

  def index
    render json: { groups: Group.all }
  end

end
