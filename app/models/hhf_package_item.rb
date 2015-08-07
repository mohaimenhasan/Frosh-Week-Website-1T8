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

  def available_by_time?
    start_time = start_date.to_time_in_current_zone.beginning_of_day
    end_time = end_date.to_time_in_current_zone.end_of_day
    Time.now.in_time_zone(Rails.application.config.time_zone).between? start_time, end_time
  end

  def available?
    return true if self.left > 0 && available_by_time?
    return false
  end 
    
  def update_amount
    self.count = self.count + 1
    self.left = self.left - 1
    self.save!
  end
end