class Api::PackagesController < ActionController::Base

  def create
    render :json => { :status => 'denied' }
  end

  def show
    render :json => { "package" => Package.find(params[:id]) }
  end

  def index
    render :json => { "packages" => Package.all }
  end

  def destroy
    render :json => { :status => 'denied' }
  end

  def update
    render :json => { :status => 'denied' }
  end

end
