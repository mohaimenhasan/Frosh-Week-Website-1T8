class Package < ActiveRecord::Base
  attr_accessible :count, :description, :end_date, :max, :name, :price, :start_date
end
