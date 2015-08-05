require 'admin_authorization'

class Api::HhfPackagesController < ApplicationController

  def show
    # print "In show controller\n"
    package = HhfPackage.find(params[:id])
    package = nil unless package.available?
    
    render json: { hhf_package: package }
  end

  def index
    # print "In packages controller\n"
    #print params
    if params.has_key? :key
       # print "getting packages"
      packages = HhfPackage.where params.slice :key

    else
      #Get all packages from database and check if they are available
      #Then render all available into json
      packages = HhfPackage.all
      
    end
    packages.keep_if {|p| p.available?}
    #Re-sort packages by price
    sorted_packages = packages.sort_by { |k| k.id }
    print sorted_packages.inspect
    render json: { hhf_packages: sorted_packages}
    
  end

end
