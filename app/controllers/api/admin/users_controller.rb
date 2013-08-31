require 'awesome_print' if Rails.env.development?

class Api::Admin::UsersController < Api::UsersController

  include AdminAuthorization
  before_filter :authorize_admin
  before_filter :check_offline_mode, only: [:send_confirmation_email, :send_receipt_email]

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
    u.update_attributes params[:user].slice(:email, :phone, :discipline, :shirt_size, :bursary_chosen, :checked_in, :restrictions_dietary, :restrictions_accessibility, :restrictions_misc)
    if params[:user].has_key?(:package_id)
      u.package = Package.find(params[:user][:package_id])
      u.save! validate: false
    end

    render json: { user: u }
  end

  def destroy
    u = User.find(params[:id])
    u.delete

    render json: { user: u }
  end

  def send_confirmation_email
    u = User.find(params[:id])
    if u.verified
      render nothing: true, status: :bad_request and return
    else
      u.send_confirmation
      render nothing: true, status: :ok and return
    end

  end

  def send_receipt_email
    u = User.find(params[:id])
    u.send_receipt
    render nothing: true, status: :ok
  end

  protected

  def add_details_from_admin(user)
    user.created_by_admin = get_admin.email
  end

  def check_offline_mode
    if Rails.application.config.offline_mode
      render nothing: true, status: :bad_request and return
    end
  end

end