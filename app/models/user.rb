# == Schema Information
#
# Table name: users
#
#  id                         :integer          not null, primary key
#  email                      :string(255)
#  verified                   :boolean
#  first_name                 :string(255)
#  last_name                  :string(255)
#  phone                      :string(255)
#  shirt_size                 :string(255)
#  residence                  :string(255)
#  discipline                 :string(255)
#  group                      :integer
#  emergency_name             :string(255)
#  emergency_relationship     :string(255)
#  emergency_phone            :string(255)
#  emergency_email            :string(255)
#  restrictions_dietary       :string(255)
#  restrictions_accessibility :string(255)
#  restrictions_misc          :string(255)
#  bursary_requested          :boolean
#  bursary_chosen             :boolean
#  confirmation_token         :string(255)
#  gender                     :string(255)
#  package_id                 :integer
#  created_at                 :datetime         not null
#  updated_at                 :datetime         not null
#

require 'validates_phone_number'
require 'mandrill'
require 'stripe'

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

class User < ActiveRecord::Base

  attr_accessible :first_name, :last_name,
                  :discipline,
                  :email,
                  :gender,
                  :shirt_size,
                  :group, :phone, :residence,
                  :package_id,
                  :bursary_requested, :bursary_chosen,
                  :confirmation_token, :verified,
                  :emergency_name, :emergency_phone, :emergency_relationship, :emergency_email,
                  :restrictions_dietary, :restrictions_accessibility, :restrictions_misc

  validates :discipline, :first_name, :last_name, :emergency_name, :emergency_relationship, presence: true, length: { maximum: 50 }
  validates :emergency_phone, :phone, presence: true, :phone_number => {:ten_digits => true}
  validates :email, :emergency_email, presence: true, format: { with: VALID_EMAIL_REGEX }
  validates :group, :shirt_size, :package_id, presence: true
  validates :verified, inclusion: { :in => [true, false] }
  validates :bursary_chosen, :bursary_requested, inclusion: { :in => [true, false] }
  validates :residence, :restrictions_dietary, :restrictions_misc, :restrictions_accessibility, length: { maximum: 50 }

  def send_confirmation
    self.confirmation_token = Digest::SHA1.hexdigest([Time.now, rand].join)
    m = Mandrill::API.new
    # TODO(amandeepg): actual data
    message = {
     :subject => 'Welcome to F!rosh Week!',
     :from_name => 'F!rosh Leedur',
     :text =>"Confirm your email. #{self.id} - #{self.confirmation_token}",
     :to => [
       {
         :email => self.email,
         :name => '#{self.first_name} #{self.last_name}'
       }
     ],
     :from_email => Rails.application.config.mandrill_from
    }
    m.messages.send message
  end

  def process_payment(token)
    Stripe.api_key = Rails.application.config.stripe_secret_key

    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      Stripe::Charge.create(
        :amount => 1000, # amount in cents, again
        :currency => 'cad',
        :card => token,
        :description => self.email,
      )

      :success
    rescue Exception => e  
      e.message
    end
  end
end

