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
  attr_accessible :key, :count, :description, :end_date, :max, :name, :price, :start_date

  has_many :users

  def available?

    print self.key 
    if (self.key == 'early-bird-standalone' ||
        self.key == 'early-bird-with-farm' ||
        self.key == 'early-bird-with-commuter' ||
        self.key == 'early-bird-all')
      available = available_early_bird?
    #elsif (self.key == 'middle-bird-standalone')
       #or self.key == 'middle-bird-with-farm' \
       #or self.key == 'middle-bird-with-commuter' \
       #or self.key == 'middle-bird-all')
      #available = available_middle_bird?
    elsif (self.key == 'standalone')
       #or self.key == 'farm' \
       #or self.key == 'commuter' \
       #or self.key == 'all')
      available = available_normal?
    elsif (self.key == 'standalone-day-of')
       #or self.key == 'farm' \
       #or self.key == 'commuter' \
       #or self.key == 'all')
      available = true
    else
      available = false
    end
    return (available_by_time? and available)
  end

  def available_early_bird?
    early_count = Package.select("sum(count)").where("key IN ('early-bird-standalone', 'early-bird-with-farm', 'early-bird-width-commuter', 'early-bird-all')").sum(:count)

    return true if early_count < 150
    return false
  end

#NOT USE IN 1T5
  def available_middle_bird?
    if !available_early_bird?
      middle_count = Package.select("sum(count)").where("key IN ('middle-bird-standalone', 'middle-bird-with-farm', 'middle-bird-with-commuter', 'middle-bird-all')").sum(:count)
      return true if middle_count < 500
    end
    return false
  end
#NOT USE END
  def available_normal?
    if available_early_bird? == false and available_middle_bird? == false
      return true if self.max == 0
    end
    return false
  end

  def available_by_count?(total_count)
    if self.max = 0 or total_count < self.max
      return true
    else
      return false
    end
  end

  def available_by_time?
    start_time = start_date.to_time_in_current_zone.beginning_of_day
    end_time = end_date.to_time_in_current_zone.end_of_day
    Time.now.in_time_zone(Rails.application.config.time_zone).between? start_time, end_time
  end

  def increase_count
    self.count = self.count + 1
    self.save!
  end
end
