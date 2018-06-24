# == Schema Information
#
# Table name: groups
#
#  id         :integer          not null, primary key
#  name       :string(255)
#  symbol     :string(255)
#  facebook_link :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Group < ActiveRecord::Base
  attr_accessible :name, :symbol, :facebook_link, :code

  has_many :users
end
