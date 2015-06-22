require 'admin_authorization'

class Api::PackagesController < ApplicationController

  def index
    if params.has_key? :key
      items = Package_Item.where params.slice :key
    else
      #Get all items from database
      #Then render all available into json
      items = Package_Item.all
    end
    #Re-sort items by Id
    sorted_items = items.sort_by { |k| k.id }

    render json: { items: sorted_items}
    
  end

end
