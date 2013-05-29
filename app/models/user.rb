# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)
#  verified               :boolean
#  first_name             :string(255)
#  last_name              :string(255)
#  phone                  :string(255)
#  shirt_size             :string(255)
#  residence              :string(255)
#  discipline             :string(255)
#  group                  :integer
#  emergency_name         :string(255)
#  emergency_relationship :string(255)
#  emergency_phone        :string(255)
#  restrictions_dietary   :string(255)
#  restrictions_misc      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#

class User < ActiveRecord::Base
  attr_accessible :discipline, :email, :emergency_name, :emergency_phone, :emergency_relationship, :first_name, :group, :last_name, :phone, :residence, :restrictions_dietary, :restrictions_misc, :shirt_size, :verified
end
