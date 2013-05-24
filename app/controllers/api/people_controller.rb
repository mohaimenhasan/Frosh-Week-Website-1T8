require 'pg'
require 'awesome_print'
require 'uuidtools'

class Api::PeopleController < ActionController::Base

  def create
    [
      :first_name, :last_name, :email, :discipline,
      :residence, :shirt_size, :emergency_contact_name,
      :emergency_contact_relationship, :emergency_contact_phone_number,
      :dietary_restrictions, :accessibility_requirements, :misc, :type
    ].each do |x|
       render :json => {:status => 'bad'} and return unless params.key? x         
    end

    conn = PGconn.open(:dbname => 'skuleorientation')
    q = 'INSERT INTO frosh (' +
      'first_name, ' +
      'last_name, ' +
      'email, ' +
      'discipline, ' +
      'residence, ' +
      'shirt_size, ' +
      'emergency_contact_name, ' +
      'emergency_contact_relationship, ' +
      'emergency_contact_phone_number, ' +
      'dietary_restrictions, ' +
      'accessibility_requirements, ' +
      'misc, ' +
      'type, ' +
      'id' +
    ')' + ' VALUES (' +
      "\'#{params[:first_name]}\', " +
      "\'#{params[:last_name]}\', " +
      "\'#{params[:email]}\', " +
      "\'#{params[:discipline]}\', " +
      "\'#{params[:residence]}\', " +
      "\'#{params[:shirt_size]}\', " +
      "\'#{params[:emergency_contact_name]}\', " +
      "\'#{params[:emergency_contact_relationship]}\', " +
      "\'#{params[:emergency_contact_phone_number]}\', " +
      "\'#{params[:dietary_restrictions]}\', " +
      "\'#{params[:accessibility_requirements]}\', " +
      "\'#{params[:misc]}\', " +
      "\'#{params[:type]}\', " +
      "\'#{UUIDTools::UUID.timestamp_create().to_s}\'" +
    ');'
    ap q
    res  = conn.exec(q)
    render :json => {:status => 'ok'}
  end

end

