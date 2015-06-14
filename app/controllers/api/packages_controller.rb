require 'admin_authorization'

class Api::PackagesController < ApplicationController

  def show
    #print "IN SHOOWW*******************************************"
    package = Package.find(params[:id])
    package = nil unless package.available?
    
    render json: { package: package }
  end

  def index
    #print "IN index*******************************************\n"
    if params.has_key? :key
      packages = Package.where params.slice :key
    else
      #Get all packages from database and check if they are available
      #Then render all available into json
      packages = Package.all
    end
    #Re-sort packages by price
    sorted_packages = packages.sort_by { |k| k.price }
    #print "********************************PRINT SORTED ***\n"
    #sorted_packages.each do |package|
    #  print package.key + "\n";
    #end
    #print "*******************DONE****\n"

    render json: { packages: sorted_packages.keep_if { |p| p.available? } }
    
  end

end
