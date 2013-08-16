require 'awesome_print' if Rails.env.development?

class Api::Admin::UsersController < Api::UsersController

  include AdminAuthorization
  before_filter :authorize_admin

  def index
  	selector = params.slice *User.accessible_attributes
  	selector.merge!({ package_id: params[:package_id] }) if params[:package_id]
  	selector.merge!({ group_id: params[:group_id] }) if params[:group_id]
    render json: {
      users: User.where(selector)
  	}
  end

  def show
    render json: {
      user: User.find(params[:id])
    }
  end

  def update
    u = User.find(params[:id])
    u.update_attributes params[:user]

    render json: { user: u }
  end

end