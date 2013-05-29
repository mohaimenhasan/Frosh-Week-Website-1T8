require 'pg'
require 'awesome_print'

class Api::PeopleController < ActionController::Base

  def create
    # Sample: POST http://0.0.0.0:3000/api/people?first_name=j&last_name=a&email=a&discipline=a&residence=a&shirt_size=a&emergency_contact_name=a&emergency_contact_relationship=a&emergency_contact_phone_number=a&dietary_restrictions=a&accessibility_requirements=a&misc=a&type=a
    new_user = User.new params.slice :discipline, :email, :emergency_name, :emergency_phone, :emergency_relationship, :first_name, :group, :last_name, :phone, :residence, :restrictions_dietary, :restrictions_misc, :shirt_size, :verified
    new_user.save
    render :json => { :status => 'ok' }
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

end
