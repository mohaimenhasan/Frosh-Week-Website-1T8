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
    #Only render available ones
    packages = HhfPackage.where(params.slice(*HhfPackage.accessible_attributes))
    #print packages.inspect
    #packages.keep_if {|p| p.available?}
    #Re-sort packages by id
    sorted_packages = packages.sort_by { |k| k.id }
    render json: {
      hhf_packages: sorted_packages
    }
  end

end
