# == Schema Information
#
# Table name: hhf_package
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  key         :string(255)
#  price       :integer
#  leedurbus   :integer 
#  fweekbus    :integer 
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class HhfPackage < ActiveRecord::Base
  attr_accessible :key, :description, :name, :price, :leedurbus, :fweekbus, :start_date, :end_date
  
  has_many :leedurs
  has_many :hhf_package_items
  
  def available?
    available = true;
    package_items = self.key.split('_')
    package_items.each do |name|
      sql_clause = "key LIKE ('" + name + "')";
      item = HhfPackageItem.where(sql_clause).first
      available = available && item.available?
    end
    return available
  end 
    
  def increase_count
    package_items = self.key.split('_')
    self.fweekbus += 1 if self.key.include? "fweek"
    self.leedurbus += 1 if self.key.include? "leedur"
    package_items.each do |name|
      sql_clause = "key LIKE ('" + name + "')";
      item = HhfPackageItem.where(sql_clause).first
      item.update_amount
    end
    self.save!
  end
end