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
#  bursary                :boolean
#  confirmation_token     :string(255)
#


require 'validates_phone_number'
require 'mandrill'

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

class User < ActiveRecord::Base
  before_save :create_confirmation
  after_save  :send_confirmation

  attr_accessible :discipline, :email, :emergency_name, :emergency_phone, :emergency_relationship, :first_name, :group, :last_name, :phone, :residence, :restrictions_dietary, :restrictions_misc, :shirt_size, :verified, :bursary, :confirmation_token

  validates :discipline, :first_name, :last_name, :emergency_name, :emergency_relationship, presence: true, length: { maximum: 50 }
  validates :emergency_phone, :phone, presence: true, :phone_number => {:ten_digits => true}
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :group, :shirt_size, presence: true
  validates :verified, inclusion: { :in => [true, false] }
  validates :bursary, inclusion: { :in => [true, false] }
  validates :residence, :restrictions_dietary, :restrictions_misc, length: { maximum: 50 }

  def create_confirmation
    self.confirmation_token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def send_confirmation
    m = Mandrill::API.new
    message = {
     :subject=> 'Welcome to F!rosh Week!',
     :from_name=> 'F!rosh Leedur',
     :text=>'Confirm your email. #{self.id} - #{self.confirmation_token}',
     :to=>[
       {
         :email=> self.email,
         :name=> '#{self.first_name} #{self.last_name}'
       }
     ],
     :from_email=>'sender@yourdomain.com'
    }
    sending = m.messages.send message
    puts sending
  end
end
