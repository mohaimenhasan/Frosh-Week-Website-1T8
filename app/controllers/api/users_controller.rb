require 'awesome_print' if Rails.env.development?

class Api::UsersController < ApplicationController

  def create
    user_data = params[:user]

    u = User.new user_data.slice *User.accessible_attributes
    add_details_from_admin(u)
    u.package = Package.find(user_data[:package_id].to_s.to_i)
    render json: { errors: u.errors }, status: 422 and return unless u.valid?

    u.set_random_gender_disc if check_skip :random_gender_disc

    unless check_skip(:skip_stripe) || u.is_created_by_admin?
      result = u.process_payment(user_data[:cc_token])
      render json: { errors: result }, status: 422 and return unless result == :success
    end

    u.save!

    u.send_confirmation unless (check_skip(:skip_confirm_email) || Rails.application.config.offline_mode)

    render json: {
      user: u.exposed_data({
        hide_confirmation_token: true,
        show_credit_info: true
      })
    }
  end

  def index
    if params.has_key? :id and params.has_key? :confirmation_token
      render json: {
        users: User.where(params.slice(:id, :confirmation_token)).map { |u| u.exposed_data }
      }
      return
    end

    render json: { users: [] }
  end

  def update
    u = User.find(params[:id])
    if u.confirmation_token == params[:user][:confirmation_token]
      u.send_receipt if (!u.bursary_requested and !u.verified)
      u.verified = params[:user][:verified]
      u.save!
      render json: {
        user: u.exposed_data({
          hide_confirmation_token: true,
          show_credit_info: true
        })
      }
      return
    end

    render json: { user: nil }
  end

  def check_skip(skip_flag)
    Rails.env.development? and params.has_key? skip_flag
  end

  protected

  def add_details_from_admin(user)
  end

end
