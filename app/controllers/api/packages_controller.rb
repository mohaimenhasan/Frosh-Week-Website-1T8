require 'admin_authorization'

class Api::PackagesController < ApplicationController

  def show
    print params
    print "In show controller\n"
    package = Package.find(params[:id])
    package = nil unless package.available?
    
    render json: { package: package }
  end

  def index
    print params
     print "In packages controller\n"
    if params.has_key? :key
       # print "getting packages"
      packages = Package.where params.slice :key
    
    else
      #Get all packages from database and check if they are available
      #Then render all available into json
      packages = Package.all
      
    end
    packages.keep_if {|p| p.available?}
    #Re-sort packages by price
    sorted_packages = packages.sort_by { |k| k.id }

    render json: { packages: sorted_packages}
    
  end

end
