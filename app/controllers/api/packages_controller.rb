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
      packages = Package.all
    end
    render json: { packages: packages.keep_if { |p| p.available? } }
  end

end
