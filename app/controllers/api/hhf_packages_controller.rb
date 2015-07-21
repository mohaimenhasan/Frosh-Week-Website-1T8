require 'admin_authorization'

class Api::HhfPackagesController < ApplicationController

  def show
    item = HhfPackage.find(params[:id])
    render json: { package_items: item }
  end
    
  def index
    #  print "in package_item index\n"
    if params.has_key? :key
      items = HhfPackage.where params.slice :key
    else
      #Get all items from database
      #Then render all available into json
      items = HhfPackage.all
    end
    #Re-sort items by Id
    sorted_items = items.sort_by { |k| k.id }

      render json: { hhf_packages: sorted_items}
    
  end

end
