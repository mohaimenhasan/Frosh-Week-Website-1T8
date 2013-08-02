require 'awesome_print' if Rails.env.development?

class Api::Admin::PackagesController < Api::PackagesController

  include AdminAuthorization
  before_filter :authorize_admin

  def index
    render json: {
      packages: Package.where(params.slice(*Package.accessible_attributes))
    }
  end

end
