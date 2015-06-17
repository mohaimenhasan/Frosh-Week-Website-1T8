require 'admin_authorization'

class Api::PackagesController < ApplicationController

  def show
    package = Package.find(params[:id])
    package = nil unless package.available?
    
    render json: { package: package }
  end

  def index
    if params.has_key? :key
      packages = Package.where params.slice :key
    else
      #Get all packages from database and check if they are available
      #Then render all available into json
      packages = Package.all
      packages.keep_if {|p| p.available?}
    end
    #Re-sort packages by price
    sorted_packages = packages.sort_by { |k| k.price }

    render json: { packages: sorted_packages}
    
  end

end
