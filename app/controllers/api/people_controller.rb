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

    conn = open_db
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

  def show
    conn = open_db
    q = "SELECT * FROM frosh WHERE id = '#{params[:id]}';"
    ap q
    res = conn.exec(q)
    ap res[0]
    render :json => {"person" => res[0]}
  end

  def index
    conn = open_db
    q = "SELECT * FROM frosh;"
    ap q
    res = conn.exec(q)
    arr = []
    res.each do |r|
      ap r
      arr.push r
    end
    render :json => {"people" => arr}
  end

  def destroy
    conn = open_db
    q = "DELETE FROM frosh WHERE id = '#{params[:id]}';"
    ap q
    res = conn.exec(q)
    ap res
    render :json => {:status => 'ok'}
  end

  private

  def open_db
    PGconn.open(:dbname => 'skuleorientation')
  end

end

