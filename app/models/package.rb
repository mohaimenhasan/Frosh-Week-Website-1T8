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
    start_time = start_date.to_time_in_current_zone.beginning_of_day
    end_time = end_date.to_time_in_current_zone.end_of_day
    Time.now.in_time_zone(Rails.application.config.time_zone).between? start_time, end_time
  end

end
