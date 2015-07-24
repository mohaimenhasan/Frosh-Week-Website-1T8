# == Schema Information
#
# Table name: hhf_package_item
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  key         :string(255)
#  description :text
#  price       :integer
#  count       :integer
#  max         :integer
#  left        :integer
#  start_date  :date
#  end_date    :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class HhfPackageItem < ActiveRecord::Base
  attr_accessible :key, :count, :description, :max, :left, :name, :price, :start_date, :end_date
  
  
  has_many :hhf_packages

  def available?
    return true if self.left > 0 
    return false
  end 
    
  def update_amount
    self.count = self.count + 1
    self.left = self.left - 1
    self.save!
  end
end