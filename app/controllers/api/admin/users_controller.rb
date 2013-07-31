require 'awesome_print' if Rails.env.development?

class Api::Admin::UsersController < Api::Admin::ApplicationController

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

end