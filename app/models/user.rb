# == Schema Information
#
# Table name: users
#
#  id                     :integer          not null, primary key
#  email                  :string(255)
#  verified               :boolean
#  first_name             :string(255)
#  last_name              :string(255)
#  phone                  :string(255)
#  shirt_size             :string(255)
#  residence              :string(255)
#  discipline             :string(255)
#  group                  :integer
#  emergency_name         :string(255)
#  emergency_relationship :string(255)
#  emergency_phone        :string(255)
#  restrictions_dietary   :string(255)
#  restrictions_misc      :string(255)
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
require 'validates_phone_number'

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

class User < ActiveRecord::Base
  attr_accessible :discipline, :email, :emergency_name, :emergency_phone, :emergency_relationship, :first_name, :group, :last_name, :phone, :residence, :restrictions_dietary, :restrictions_misc, :shirt_size, :verified

  validates :discipline, presence: true, length: { maximum: 50 }
  validates :first_name, presence: true, length: { maximum: 50 }
  validates :emergency_name, presence: true, length: { maximum: 50 }
  validates :emergency_relationship, presence: true, length: { maximum: 50 }
  validates :emergency_phone, presence: true, :phone_number => {:ten_digits => true}
  validates :phone, presence: true, :phone_number => {:ten_digits => true}
  validates :last_name, presence: true, length: { maximum: 50 }
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :group, presence: true
  validates :shirt_size, presence: true
  validates :verified, inclusion: { :in => [true, false] }
  validates :residence, length: { maximum: 50 }
  validates :restrictions_dietary, length: { maximum: 250 }
  validates :restrictions_misc, length: { maximum: 250 }
end
