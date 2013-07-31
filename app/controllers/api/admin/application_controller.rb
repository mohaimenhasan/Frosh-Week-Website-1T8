class Api::Admin::ApplicationController < ApplicationController

  include AdminAuthorization
  before_filter :authorize_admin

end
