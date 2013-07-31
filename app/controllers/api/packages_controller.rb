require 'admin_authorization'

class Api::PackagesController < ApplicationController

  def show
    render json: { package: Package.find(params[:id]) }
  end

  def index
    if params.has_key? :key
      packages = Package.where params.slice :key
    else
      packages = Package.all
    end
    render json: { packages: packages }
  end

end
