require 'awesome_print' if Rails.env.development?

class Api::Admin::GroupsController < Api::GroupsController

  include AdminAuthorization
  before_filter :authorize_admin

  def index
    render json: {
      groups: Group.where(params.slice(*Group.accessible_attributes))
    }
  end

end
