require 'awesome_print' if Rails.env.development?

class Api::LeedursController < ApplicationController

  def create
    print "IN CREATE\n"
    leedur_data = params[:leedur]

    u = Leedur.new leedur_data.slice *Leedur.accessible_attributes
    print "Got: "
    print u.inspect
    print "\n"
    add_details_from_admin(u)
    u.hhf_package = HhfPackage.find(leedur_data[:hhf_package_id].to_s.to_i)
    print"Validating leedur\n"
    render json: { errors: u.errors }, status: 422 and return unless u.valid?

    u.set_random_gender_disc if check_skip :random_gender_disc
    print "Payment start\n"
    unless check_skip(:skip_stripe) || u.is_created_by_admin?
      result = u.process_payment(leedur_data[:cc_token])
      render json: { errors: result }, status: 422 and return unless result == :success
    end
    print "Saving"
    print u.inspect
    print "\n"
    u.save!
    print "Send email\n"
    u.send_confirmation unless (check_skip(:skip_confirm_email) || Rails.application.config.offline_mode)
    print "Done\n"
    render json: {
      leedur: u.exposed_data({
        hide_confirmation_token: true,
        show_credit_info: true
      })
    }
  end

  def index
    if params.has_key? :id and params.has_key? :confirmation_token
      render json: {
        leedurs: Leedur.where(params.slice(:id, :confirmation_token)).map { |u| u.exposed_data }
      }
      return
    end

    render json: { leedurs: [] }
  end

  def update
    u = Leedur.find(params[:id])
    if u.confirmation_token == params[:leedur][:confirmation_token]
      u.send_receipt if (!u.verified)
      u.verified = params[:leedur][:verified]
      u.save!
      render json: {
        leedur: u.exposed_data({
          hide_confirmation_token: true,
          show_credit_info: true
        })
      }
      return
    end

    render json: { leedur: nil }
  end

  def check_skip(skip_flag)
    Rails.env.development? and params.has_key? skip_flag
  end

  protected

  def add_details_from_admin(leedur)
  end

end
