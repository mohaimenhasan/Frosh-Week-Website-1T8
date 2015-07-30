require 'awesome_print' if Rails.env.development?

class Api::Admin::HhfPackageItemsController < Api::HhfPackageItemsController

  include AdminAuthorization
  before_filter :authorize_admin

 def show
        item = HhfPackageItem.find(params[:id])
        render json: { hhf_package_items: item }
  end
    
  def index
    #  print "in package_item index\n"
    if params.has_key? :key
      items = HhfPackageItem.where params.slice :key
    else
      #Get all items from database
      #Then render all available into json
      items = HhfPackageItem.all
    end
    #Re-sort items by Id
    sorted_items = items.sort_by { |k| k.id }

    render json: { hhf_package_items: sorted_items}
    
  end

end