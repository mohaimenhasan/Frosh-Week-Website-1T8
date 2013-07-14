require 'awesome_print' if Rails.env.development?
require 'admin_authorization'

class Api::GroupsController < ActionController::Base

  include AdminAuthorization

  before_filter :authorize_admin, except:[:show, :index]

  def create
  end

  def show
    render json: { user: Group.find(params[:id]) }
  end

  def index
    render json: { users: Group.all }
  end

  def destroy
  end

  def update
  end

end
