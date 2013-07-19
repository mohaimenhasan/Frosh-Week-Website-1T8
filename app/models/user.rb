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
#  ticket_number                  :string(255)
#  group_id                       :integer
#  package_id                     :integer
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#

require 'mandrill'
require 'stripe'
require 'erb'
require 'global_phone'
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
                  :bursary_paid, :bursary_engineering_motivation, :bursary_financial_reasoning,
                  :confirmation_token, :verified,
                  :emergency_name, :emergency_phone, :emergency_relationship, :emergency_email,
                  :restrictions_dietary, :restrictions_accessibility, :restrictions_misc,
                  :charge_id, :ticket_number

  belongs_to :group
  belongs_to :package

  validates :first_name, :last_name, :emergency_name, :emergency_relationship, presence: true, length: { maximum: 50 }
  validates :discipline, inclusion: { in: ['Engineering Science', 'Track One', 'Chemical', 'Civil', 'Computer', 'Electrical', 'Industrial', 'Material Science', 'Mechanical', 'Mineral'] }
  validates :email, :emergency_email, presence: true, format: { with: VALID_EMAIL_REGEX } 
  validates :shirt_size, inclusion: { in: ['Small', 'Medium', 'Large', 'Extra Large']}
  validates :verified, inclusion: { in: [true, false] }
  validates :bursary_chosen, inclusion: { in: [nil, true, false] }
  validates :bursary_requested, inclusion: { in: [true, false] }
  validates :bursary_engineering_motivation, :bursary_financial_reasoning, presence: true, length: { maximum: 2000 }, if: :bursary_requested?
  validates :bursary_paid, :bursary_osap, inclusion: { in: [true, false] }, if: :bursary_requested?
  validates :residence, length: { maximum: 50 }
  validates :restrictions_dietary, :restrictions_misc, :restrictions_accessibility, length: { maximum: 2000 }
  validates :gender, inclusion: { in: ['Male', 'Female', '-'] }
  validate  :validate_all_phone_numbers

  before_save :normalize_phones

  def validate_all_phone_numbers
    if phone && !GlobalPhone.validate(phone)
      errors.add(:phone, "is invalid")
    end
    unless GlobalPhone.validate(emergency_phone)
      errors.add(:emergency_phone, "is invalid")
    end
  end

  def exposed_data(opts={})
    data = attributes
    data.except!('confirmation_token') if opts[:hide_confirmation_token]
    data.merge! credit_info if opts[:show_credit_info]

    data['phone'] = formatted_phone phone if phone
    data['emergency_phone'] = formatted_phone emergency_phone if emergency_phone

    data
  end

  def formatted_phone(phone_international)
      number = GlobalPhone.parse phone_international
      number.territory.name == 'US' ? number.national_format : number.international_format
  end

  def formatted_date(date_time)
    date_time.to_time.in_time_zone('Eastern Time (US & Canada)').strftime('%b %e, %Y')
  end

  def create_token
    self.confirmation_token = Digest::SHA1.hexdigest([Time.now, rand].join)
    save!
  end

  def create_ticket_number
    self.ticket_number = (id.to_i * 100) + rand(100) + 100_000
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
         email: email,
         name: "#{first_name} #{last_name}"
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
         email: email,
         name: "#{first_name} #{last_name}"
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
        amount: package.price * 100, # amount in cents
        currency: 'cad',
        card: token,
        description: email,
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

  def normalize_phones
    self.phone = GlobalPhone.normalize(phone) if phone
    self.emergency_phone = GlobalPhone.normalize(emergency_phone)
  end

  def get_shirt_size_abbr
    case shirt_size
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

  def get_confirm_url
    'http://' + Rails.application.config.hostname + '/register/confirm/' + id.to_s + '/' + confirmation_token
  end

  def get_billing_last4
    return nil unless charge_id
    Stripe::Charge.retrieve(charge_id)["card"]["last4"]
  end

  def get_billing_name
    return nil unless charge_id
    Stripe::Charge.retrieve(charge_id)["card"]["name"]
  end

  def get_billing_type
    return nil unless charge_id
    Stripe::Charge.retrieve(charge_id)["card"]["type"]
  end

  def credit_info
    return {} unless charge_id

    card = Stripe::Charge.retrieve(charge_id)["card"]
    {
      cc_name: card["name"],
      cc_last4: card["last4"],
      cc_type: card["type"],
    }
  end

end

