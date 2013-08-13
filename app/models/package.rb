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
    Time.now.in_time_zone('Eastern Time (US & Canada)').between? start_date.to_time.beginning_of_day, end_date.to_time.end_of_day
  end

end
