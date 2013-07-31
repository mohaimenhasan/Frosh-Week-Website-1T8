require 'awesome_print' if Rails.env.development?

class Api::Admin::GroupsController < Api::Admin::ApplicationController

  def index
    render json: {
      groups: Group.where(params.slice(*Group.accessible_attributes))
    }
  end

  def show
    render json: {
      group: Group.find(params[:id])
    }
  end

end
