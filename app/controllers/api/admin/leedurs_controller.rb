require 'awesome_print' if Rails.env.development?

class Api::Admin::LeedursController < Api::LeedursController

  include AdminAuthorization
  before_filter :authorize_admin
  before_filter :check_offline_mode, only: [:send_confirmation_email, :send_receipt_email]

  def index
    selector = params.slice *Leedur.accessible_attributes
    selector.merge!({ hhf_package_id: params[:hhf_package_id] }) if params[:hhf_package_id]
    render json: {
      leedurs: Leedur.where(selector)
    }
  end

  def show
    render json: {
      leedur: Leedur.find(params[:id])
    }
  end

  def update
    u = Leedur.find(params[:id])
    u.update_attributes params[:leedur].slice(:email, :phone, :discipline, :year, :checked_in, :restrictions_dietary, :restrictions_misc)
    if params[:leedur].has_key?(:hhf_package_id)
      u.hhf_package = HhfPackage.find(params[:leedur][:hhf_package_id])
      u.save! validate: false
    end

    render json: { leedur: u }
  end

  def destroy
    u = Leedur.find(params[:id])
    u.delete

    render json: { leedur: u }
  end

  def send_confirmation_email
    u = Leedur.find(params[:id])
    if u.verified
      render nothing: true, status: :bad_request and return
    else
      u.send_confirmation
      render nothing: true, status: :ok and return
    end

  end

  def send_receipt_email
    u = Leedur.find(params[:id])
    u.send_receipt
    render nothing: true, status: :ok
  end

  protected

  def add_details_from_admin(leedur)
    leedur.created_by_admin = get_admin.email
  end

  def check_offline_mode
    if Rails.application.config.offline_mode
      render nothing: true, status: :bad_request and return
    end
  end

end