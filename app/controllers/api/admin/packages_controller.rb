require 'awesome_print' if Rails.env.development?

class Api::Admin::PackagesController < Api::Admin::ApplicationController

  def index
    render json: {
      packages: Package.where(params.slice(*Package.accessible_attributes))
    }
  end

  def show
    render json: {
      package: Package.find(params[:id])
    }
  end

end
