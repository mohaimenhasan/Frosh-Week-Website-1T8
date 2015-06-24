require 'admin_authorization'

class Api::PackageItemsController < ApplicationController

  def show
        item = PackageItem.find(params[:id])
        render json: { package_items: item }
  end
    
  def index
      print "in package_item index\n"
    if params.has_key? :key
      items = PackageItem.where params.slice :key
    else
      #Get all items from database
      #Then render all available into json
      items = PackageItem.all
    end
    #Re-sort items by Id
    sorted_items = items.sort_by { |k| k.id }

    render json: { package_items: sorted_items}
    
  end

end
