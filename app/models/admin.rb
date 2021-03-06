# == Schema Information
#
# Table name: admins
#
#  id                :integer          not null, primary key
#  email             :string(255)
#  authorized_routes :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

class Admin < ActiveRecord::Base
  attr_accessible :authorized_routes, :email
end
