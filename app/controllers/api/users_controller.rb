require 'pg'
require 'awesome_print'
require 'stripe'
require 'yaml'

class Api::UsersController < ActionController::Base

  def create
    # Sample: POST http://0.0.0.0:3000/api/users?discipline=NY=&email=letsmakeithappen@itsgottobenow.com&emergency_name=Fido&emergency_phone=4165554444&emergency_relationship=dog&first_name=bob&group=1&last_name=last&phone=4161112222&shirt_size=M&skip_stripe=yes
    params[:verified] = false
    params[:bursary] = params.has_key?(:bursary) and params[:bursary].to_bool_with_default

    unless params.has_key? :skip_stripe and params[:skip_stripe].to_bool
      # Set your secret key: remember to change this to your live secret key in production
      # See your keys here https://manage.stripe.com/account
      Stripe.api_key = YAML.load_file('stripe_api_key.yml')

      # Get the credit card details submitted by the form
      token = params[:stripeToken]

      # Create the charge on Stripe's servers - this will charge the user's card
      begin
        charge = Stripe::Charge.create(
          :amount => 1000, # amount in cents, again
          :currency => "cad",
          :card => token,
          :description => "payinguser@example.com"
        )
      rescue Stripe::CardError => e
        render :json => { :status => 'card rejected' } and return
      end
    end

    new_user = User.new params.slice :discipline, :email, :emergency_name, :emergency_phone, :emergency_relationship, :first_name, :group, :last_name, :phone, :residence, :restrictions_dietary, :restrictions_misc, :shirt_size, :verified, :bursary
    new_user.save
    ap new_user.errors
    render :json => { :status => new_user.valid? }
  end

  def show
    render :json => { "person" => User.find(params[:id]) }
  end

  def index
    render :json => { "people" => User.all }
  end

  def destroy
    User.find(params[:id]).destroy
    render :json => { :status => 'ok' }
  end

  def update
    User.find(params[:id]).update_attributes params.slice :discipline, :email, :emergency_name, :emergency_phone, :emergency_relationship, :first_name, :group, :last_name, :phone, :residence, :restrictions_dietary, :restrictions_misc, :shirt_size, :verified
    render :json => { :status => 'ok' }
  end

  def confirm
    u = User.find(params[:id])
    u.verified = true if u.confirmation_token == params[:token]
    render :json => { :status => u.verified }
  end

end
