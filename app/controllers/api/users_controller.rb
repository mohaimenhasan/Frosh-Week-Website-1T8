require 'awesome_print'
require 'admin_authorization'

class Api::UsersController < ActionController::Base

  include AdminAuthorization

  before_filter :authorize_admin, :except => [:create, :confirm]

  def create
    # Sample: POST http://0.0.0.0:3000/api/users?discipline=NY=&email=letsmakeithappen@itsgottobenow.com&emergency_name=Fido&emergency_phone=4165554444&emergency_relationship=dog&first_name=bob&group=1&last_name=last&phone=4161112222&shirt_size=M&skip_stripe=yes&skip_confirm_email=true
    params[:verified] = false
    params[:bursary] = params.has_key?(:bursary) and params[:bursary].to_bool_with_default

    new_user = User.new params.slice :discipline, :email, :emergency_name, :emergency_phone, :emergency_relationship, :first_name, :group, :last_name, :phone, :residence, :restrictions_dietary, :restrictions_misc, :shirt_size, :verified, :bursary
    ap new_user.errors

    if new_user.valid?
      unless Rails.env.development? and params.has_key? :skip_stripe
        result = new_user.process_payment(params[:stripe_token])
        unless result == :success
          render :json => { :errors => result } and return
        end
      end

      unless Rails.env.development? and params.has_key? :skip_confirm_email
        new_user.send_confirmation
      end

      new_user.save!
      render :json => { :person => new_user.except :confirmation_token }
    else
      render :json => { :errors => new_user.errors }
    end
  end

  def show
    render :json => { :person => User.find(params[:id]) }
  end

  def index
    render :json => { :people => User.all }
  end

  def destroy
    User.find(params[:id]).destroy
    render :json => { :status => :ok }
  end

  def update
    User.find(params[:id]).update_attributes params.slice :discipline, :email, :emergency_name, :emergency_phone, :emergency_relationship, :first_name, :group, :last_name, :phone, :residence, :restrictions_dietary, :restrictions_misc, :shirt_size, :verified
    render :json => { :status => :ok }
  end

  def confirm
    u = User.find(params[:id])
    u.verified = true if u.confirmation_token == params[:token]
    render :json => { :status => u.except :confirmation_token  }
  end

end
