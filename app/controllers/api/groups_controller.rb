require 'awesome_print' if Rails.env.development?

class Api::GroupsController < ApplicationController

  def show
      render json: { group: Group.find(params[:id]) }
  end

  def index
    render json: { groups: Group.all }
  end

end
