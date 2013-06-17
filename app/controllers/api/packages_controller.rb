class Api::PackagesController < ActionController::Base

  def create
    render :json => { :status => 'denied' }
  end

  def show
    render :json => { 'package' => Package.find(params[:id]) }
  end

  def index
    if params.has_key? :name
      packages = Package.where params.slice :name
    else
      packages = Package.all
    end
    render :json => { 'packages' => packages }
  end

  def destroy
    render :json => { :status => 'denied' }
  end

  def update
    render :json => { :status => 'denied' }
  end

end
