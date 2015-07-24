# == Schema Information
#
# Table name: hhf_package
#
#  id          :integer          not null, primary key
#  name        :string(255)
#  key         :string(255)
#  price       :integer
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class HhfPackage < ActiveRecord::Base
  attr_accessible :key, :count, :description, :max, :left, :name, :price, :start_date, :end_date
  
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
    print "Increasing " + self.key + "count\n"
    package_items = self.key.split('_')
    package_items.each do |name|
      sql_clause = "key LIKE ('" + name + "')";
      item = HhfPackageItem.where(sql_clause).first
      item.update_amount
    end
  end
end