require 'awesome_print' if Rails.env.development?

class Api::Admin::PackagesController < Api::PackagesController

  include AdminAuthorization
  before_filter :authorize_admin

  def show
    render json: {
      user: Package.find(params[:id])
    }
  end

  def index
    #Only render available ones
    packages = Package.where(params.slice(*Package.accessible_attributes))
    packages.keep_if {|p| p.available?}
    #Re-sort packages by id
    sorted_packages = packages.sort_by { |k| k.id }
    render json: {
      packages: sorted_packages
    }
  end

end
