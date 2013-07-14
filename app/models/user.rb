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
#  charge_id                      :string(255)
#  group_id                       :integer
#  package_id                     :integer
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#

require 'phony'
require 'mandrill'
require 'stripe'
require 'erb'
require 'awesome_print' if Rails.env.development?

VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

class User < ActiveRecord::Base

  attr_accessible :first_name, :last_name,
                  :discipline,
                  :email,
                  :gender,
                  :shirt_size,
                  :phone, :residence,
                  :bursary_requested, :bursary_chosen,
                  :bursary_paid, :bursary_scholarship_amount, :bursary_engineering_motivation, :bursary_financial_reasoning, :bursary_after_graduation,
                  :confirmation_token, :verified,
                  :emergency_name, :emergency_phone, :emergency_relationship, :emergency_email,
                  :restrictions_dietary, :restrictions_accessibility, :restrictions_misc,
                  :charge_id, :ticket_number

  belongs_to :group
  belongs_to :package

  phony_normalize :phone, default_country_code: 'US'
  phony_normalize :emergency_phone, default_country_code: 'US'

  validates :first_name, :last_name, :emergency_name, :emergency_relationship, presence: true, length: { maximum: 50 }
  validates :discipline, inclusion: { in: ['Engineering Science', 'Track One', 'Chemical', 'Civil', 'Computer', 'Electrical', 'Industrial', 'Material Science', 'Mechanical', 'Mineral'] }
  validates_plausible_phone :phone, allow_blank: true
  validates_plausible_phone :emergency_phone
  validates :email, :emergency_email, presence: true, format: { with: VALID_EMAIL_REGEX } 
  validates :shirt_size, inclusion: { in: ['Small', 'Medium', 'Large', 'Extra Large']}
  validates :verified, inclusion: { in: [true, false] }
  validates :bursary_chosen, inclusion: { in: [nil, true, false] }
  validates :bursary_requested, inclusion: { in: [true, false] }
  validates :bursary_engineering_motivation, :bursary_financial_reasoning, :bursary_after_graduation, presence: true, length: { maximum: 2000 }, if: :bursary_requested?
  validates :bursary_scholarship_amount, inclusion: { in: 1..100_0000 }, if: :bursary_requested?
  validates :bursary_paid, inclusion: { in: [true, false] }, if: :bursary_requested?
  validates :residence, length: { maximum: 50 }
  validates :restrictions_dietary, :restrictions_misc, :restrictions_accessibility, length: { maximum: 2000 }
  validates :gender, inclusion: { in: ['Male', 'Female', '-'] }

  def create_token
    self.confirmation_token = Digest::SHA1.hexdigest([Time.now, rand].join)
    save!
  end

  def create_ticket_number
    self.ticket_number = (self.id.to_i * 100) + rand(100)
    self.ticket_number = self.ticket_number.to_s.rjust(6, '0')
    save!
  end

  def set_random_gender_disc
    disps = ['Engineering Science', 'Track One', 'Chemical', 'Civil', 'Computer', 'Electrical', 'Industrial', 'Material Science', 'Mechanical', 'Mineral']
    genders = ['Male', 'Female']
    self.gender = genders[rand genders.count]
    self.discipline = disps[rand disps.count]
  end

  def send_confirmation
    message = {
     subject: '[Orientation] Required registration step - Confirm your email',
     from_name: 'University of Toronto Engineering Orientation',
     html: ERB.new(File.read(Rails.root.join('app/views/email_confirm.html.erb'))).result(binding),
     to: [
       {
         email: self.email,
         name: "#{self.first_name} #{self.last_name}"
       }
     ],
     from_email: Rails.application.config.mandrill_from
    }
    Mandrill::API.new.messages.send message
  end

  def send_receipt
    message = {
     subject: '[Orientation] Required registration step - Confirm your email',
     from_name: 'University of Toronto Engineering Orientation',
     html: ERB.new(File.read(Rails.root.join('app/views/email_receipt.html.erb'))).result(binding),
     to: [
       {
         email: self.email,
         name: "#{self.first_name} #{self.last_name}"
       }
     ],
     from_email: Rails.application.config.mandrill_from
    }
    Mandrill::API.new.messages.send message
  end

  def process_payment(token)
    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = Stripe::Charge.create(
        amount: self.package.price * 100, # amount in cents
        currency: 'cad',
        card: token,
        description: self.email,
      )

      self.charge_id = charge["id"]
      save!

      :success
    rescue Stripe::CardError => e
      code = e.json_body[:error][:code]
      type = e.json_body[:error][:type]
      error_to_return = code ? code : type
      { cc_token: [error_to_return] }
    rescue Stripe::StripeError => e
      { cc_token: [e.message] }
    end
  end

  def get_shirt_size_abbr
    case self.shirt_size
    when 'Small'
      'S'
    when 'Medium'
      'M'
    when 'Large'
      'L'
    when 'Extra Large'
      'XL'
    end
  end

  def get_symbol_utf
    self.group.symbol.gsub(/\\u([\da-fA-F]{4})/) {|m| [$1].pack("H*").unpack("n*").pack("U*")}
  end

  def get_billing_last4
    Stripe::Charge.retrieve(self.charge_id)["card"]["last4"]
  end

  def get_billing_name
    Stripe::Charge.retrieve(self.charge_id)["card"]["name"]
  end

  def get_billing_type
    Stripe::Charge.retrieve(self.charge_id)["card"]["type"]
  end

end

