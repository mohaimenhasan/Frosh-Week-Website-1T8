class Admin < ActiveRecord::Base
  attr_accessible :authorized_routes, :email
end
