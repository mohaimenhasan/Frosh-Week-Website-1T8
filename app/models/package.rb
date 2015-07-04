# == Schema Information
#
# Table name: packages
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  key         :string(255)
#  description :text
#  price       :integer
#  count       :integer
#  max         :integer
#  start_date  :date
#  end_date    :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Package < ActiveRecord::Base
  attr_accessible :key, :name, :count,  :max,   :price, :start_date ,:end_date

  has_many :users
  has_many :package_items
    
  def available?

   # print "IN RUBY: " + self.key 
    if (self.key == 'early-bird-standalone')
      available = available_early_bird?
    elsif (self.key == 'early-bird-standalone_commuter')
      available = available_early_bird? && available_commuter?
    elsif (self.key == 'early-bird-standalone_farm')
      available = available_early_bird? && available_hhf?
    elsif (self.key == 'early-bird-standalone_farm_commuter')
      available = available_early_bird? && available_hhf? && available_commuter?
        
    elsif (self.key == 'standalone')
      available = available_normal?
    elsif (self.key == 'standalone_commuter')
      available = available_normal? && available_commuter?
    elsif (self.key == 'standalone_farm')
      available = available_normal? && available_hhf?
    elsif (self.key == 'standalone_farm_commuter')
      available = available_normal? && available_hhf? && available_commuter?
    else 
      available = false
    end
    return (available_by_time? and available)

  end

  def available_early_bird?
    item = PackageItem.where("key LIKE ('early-bird-standalone')")
    #Return an array rather than an object 
    early_count=item.first.left;
    #print  early_count 
    return true if early_count > 0
    return false
  end
  def available_commuter?
    item = PackageItem.where("key LIKE ('commuter')")
    commuter_count = item.first.left
    #print commuter_count 
    return true if commuter_count > 0 
    return false
  end
  def available_normal?
    if available_early_bird? == false 
      return true if PackageItem.where("key LIKE ('standalone')").first.max == 0
    end
      return false
  end
  def available_hhf?
    item = PackageItem.where("key LIKE ('farm')")
    farm_count = item.first.left
    #print farm_count 
    return true if farm_count > 0 
    return false
  end


  def available_by_time?
    start_time = start_date.to_time_in_current_zone.beginning_of_day
    end_time = end_date.to_time_in_current_zone.end_of_day
    Time.now.in_time_zone(Rails.application.config.time_zone).between? start_time, end_time
  end

  def increase_count
    self.count = self.count + 1
      package_items = self.key.split('_')
      package_items.each do |name|
      sql_clause = "key LIKE ('" + name + "')";
      item = PackageItem.where(sql_clause).first
      item.update_amount
      end
    self.save!
  end
end
