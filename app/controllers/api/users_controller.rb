require 'awesome_print'
require 'admin_authorization'

class Api::UsersController < ActionController::Base

  include AdminAuthorization

  before_filter :authorize_admin, :except => [:create, :confirm]

  def create
    # Sample: POST http://0.0.0.0:3000/api/users?discipline=NY&email=letsmakeithappen@itsgottobenow.com&emergency_name=Fido&emergency_phone=4165554444&emergency_relationship=dog&first_name=bob&last_name=last&phone=4161112222&shirt_size=M&gender=m&package_id=3&bursary_requested=true&emergency_email=bob@bob.com&skip_stripe=yes&skip_confirm_email=true
    
    new_user = User.new params.slice *User.accessible_attributes
    new_user.verified = false
    new_user.bursary_requested = (params.has_key?(:bursary_requested) and params[:bursary_requested].to_bool_with_default)
    new_user.bursary_chosen = false
    new_user.group = 2 #TODO(amandeepg): group_placer

    if new_user.valid?
      unless (Rails.env.development? and params.has_key? :skip_stripe) or new_user.bursary_requested
        result = new_user.process_payment(params[:stripe_token])
        unless result == :success
          render :json => { :errors => result }, :status => 422 and return
        end
      end

      unless Rails.env.development? and params.has_key? :skip_confirm_email
        new_user.send_confirmation
      end

      new_user.save!
      render :json => { :person => new_user.attributes.except('confirmation_token') }
    else
      render :json => { :errors => new_user.errors }, :status => 422
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
    render :json => { :status => :denied }
  end

  def confirm
    u = User.find(params[:id])
    u.verified = true if u.confirmation_token == params[:token]
    render :json => { :status => u.attributes.except('confirmation_token') }
  end

end
