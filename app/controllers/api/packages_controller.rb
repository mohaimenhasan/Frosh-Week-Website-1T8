require 'admin_authorization'

class Api::PackagesController < ActionController::Base

  include AdminAuthorization

  before_filter :authorize_admin, except: [:show, :index]

  def create; end

  def show
    render json: { package: Package.find(params[:id]) }
  end

  def index
    if params.has_key? :name
      packages = Package.where params.slice :name
    else
      packages = Package.all
    end
    render json: { packages: => packages }
  end

  def destroy; end

  def update; end

end
