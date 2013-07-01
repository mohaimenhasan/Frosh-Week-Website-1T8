# == Schema Information
#
# Table name: users
#
#  id                             :integer          not null, primary key
#  first_name                     :string(255)
#  last_name                      :string(255)
#  discipline                     :string(255)
#  email                          :string(255)
#  gender                         :string(255)
#  shirt_size                     :string(255)
#  phone                          :string(255)
#  residence                      :string(255)
#  package_id                     :integer
#  bursary_requested              :boolean
#  bursary_chosen                 :boolean
#  bursary_paid                   :boolean
#  bursary_scholarship_amount     :integer
#  bursary_engineering_motivation :text
#  bursary_financial_reasoning    :text
#  bursary_after_graduation       :text
#  confirmation_token             :string(255)
#  verified                       :boolean
#  emergency_name                 :string(255)
#  emergency_phone                :string(255)
#  emergency_relationship         :string(255)
#  emergency_email                :string(255)
#  restrictions_dietary           :text
#  restrictions_accessibility     :text
#  restrictions_misc              :text
#  group_id                       :integer
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#

require 'phony'
require 'mandrill'
require 'stripe'
require 'awesome_print' if Rails.env.development?

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

class User < ActiveRecord::Base

  attr_accessible :first_name, :last_name,
                  :discipline,
                  :email,
                  :gender,
                  :shirt_size,
                  :phone, :residence,
                  :package_id,
                  :bursary_requested, :bursary_chosen,
                  :bursary_paid, :bursary_scholarship_amount, :bursary_engineering_motivation, :bursary_financial_reasoning, :bursary_after_graduation,
                  :confirmation_token, :verified,
                  :emergency_name, :emergency_phone, :emergency_relationship, :emergency_email,
                  :restrictions_dietary, :restrictions_accessibility, :restrictions_misc

  belongs_to :group

  phony_normalize :phone, default_country_code: 'US'
  phony_normalize :emergency_phone, default_country_code: 'US'

  validates :first_name, :last_name, :emergency_name, :emergency_relationship, presence: true, length: { maximum: 50 }
  validates :discipline, inclusion: { in: ['Engineering Science', 'Track One', 'Chemical', 'Civil', 'Computer', 'Electrical', 'Industrial', 'Material Science', 'Mechanical', 'Mineral'] }
  validates_plausible_phone :phone, allow_blank: true
  validates_plausible_phone :emergency_phone
  validates :email, :emergency_email, presence: true, format: { with: VALID_EMAIL_REGEX } 
  validates :shirt_size, inclusion: { in: ['Small', 'Medium', 'Large', 'Extra Large']}
  validates :package_id, inclusion: { in: 1..Package.count }
  validates :verified, inclusion: { in: [true, false] }
  validates :bursary_chosen, inclusion: { in: [nil, true, false] }
  validates :bursary_requested, inclusion: { in: [true, false] }
  validates :bursary_engineering_motivation, :bursary_financial_reasoning, :bursary_after_graduation, presence: true, length: { maximum: 2000 }, if: :bursary_requested?
  validates :bursary_scholarship_amount, inclusion: { in: 1..100_0000 }, if: :bursary_requested?
  validates :bursary_paid, inclusion: { in: [true, false] }, if: :bursary_requested?
  validates :residence, length: { maximum: 50 }
  validates :restrictions_dietary, :restrictions_misc, :restrictions_accessibility, length: { maximum: 2000 }
  validates :gender, inclusion: { in: ['Male', 'Female', '-'] }

  def send_confirmation
    self.confirmation_token = Digest::SHA1.hexdigest([Time.now, rand].join)
    m = Mandrill::API.new
    # TODO(amandeepg): actual data
    message = {
     subject: 'Welcome to F!rosh Week!',
     from_name: 'F!rosh Leedur',
     text: "Confirm your email. #{self.id} - #{self.confirmation_token}",
     to: [
       {
         email: self.email,
         name: "#{self.first_name} #{self.last_name}"
       }
     ],
     from_email: Rails.application.config.mandrill_from
    }
    m.messages.send message
  end

  def process_payment(token)
    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      Stripe::Charge.create(
        amount: Package.find(self.package_id.to_i).price * 100, # amount in cents
        currency: 'cad',
        card: token,
        description: self.email,
      )

      :success
    rescue Stripe::CardError => e
      code = e.json_body[:code]
      type = e.json_body[:type]
      error_to_return = code ? code : type
      { stripe: error_to_return }
    rescue Stripe::StripeError => e
      { stripe: e.message }
    end
  end
end

