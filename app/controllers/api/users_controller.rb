require 'awesome_print' if Rails.env.development?

class Api::UsersController < ActionController::Base

  def create  
    user_data = params[:user]

    u = User.new user_data.slice *User.accessible_attributes
    render json: { errors: u.errors }, status: 422 and return unless u.valid?

    u.set_random_gender_disc if Rails.env.development? and params.has_key? :random_gender_disc
    u.package = Package.find(user_data[:package_id].to_s.to_i)

    u.save!

    unless (Rails.env.development? and params.has_key? :skip_stripe) or u.bursary_requested
      result = u.process_payment(user_data[:cc_token])
      render json: { errors: result }, status: 422 and return unless result == :success
    end

    u.send_confirmation unless Rails.env.development? and params.has_key? :skip_confirm_email

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

end
