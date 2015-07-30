require 'awesome_print' if Rails.env.development?

class Api::Admin::HhfPackagesController < Api::HhfPackagesController

  include AdminAuthorization
  before_filter :authorize_admin

  def show
    render json: {
      leedur: HhfPackage.find(params[:id])
    }
  end

  def index
    render json: {
      hhf_packages: HhfPackage.where(params.slice(*HhfPackage.accessible_attributes))
    }
  end

end
