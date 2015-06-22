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
#  left        :integer
#  start_date  :date
#  end_date    :date
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Package_Item < ActiveRecord::Base
  attr_accessible :key, :count, :description, :max, :left, :name, :price, :start_date, :end_date

  def update_amount
    self.count = self.count + 1
    self.left = self.left - 1
    self.save!
  end
end
