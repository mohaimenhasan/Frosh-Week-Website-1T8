# == Schema Information
#
# Table name: leedurs
#
#  id                             :integer          not null, primary key
#  first_name                     :string(255)
#  last_name                      :string(255)
#  year                           :string(255)
#  discipline                     :string(255)
#  email                          :string(255)
#  gender                         :string(255)
#  phone                          :string(255)
#  confirmation_token             :string(255)
#  verified                       :boolean
#  leedurbus                      :boolean
#  fweekbus                       :boolean
#  emergency_name                 :string(255)
#  emergency_phone                :string(255)
#  emergency_relationship         :string(255)
#  emergency_email                :string(255)
#  restrictions_dietary           :text
#  restrictions_misc              :text
#  charge_id                      :string(255)
#  ticket_number                  :string(255)
#  hhf_package_id                     :integer
#  created_at                     :datetime         not null
#  updated_at                     :datetime         not null
#

require 'mandrill'
require 'stripe'
require 'erb'
require 'global_phone'
require 'awesome_print' if Rails.env.development?

VALID_UTMAIL_REGEX = /\A[\w+\-.]+@mail.utoronto.ca/i
VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

class Leedur < ActiveRecord::Base

  attr_accessible :first_name, :last_name,
                  :year, :discipline,
                  :email,
                  :gender,
                  :phone, 
                  :confirmation_token, :verified, :leedurbus, :fweekbus, :tent,
                  :emergency_name, :emergency_phone, :emergency_relationship, :emergency_email,
                  :restrictions_dietary, :restrictions_misc,
                  :charge_id, :ticket_number,
                  :checked_in

  attr_protected :created_by_admin

  belongs_to :hhf_package

  validates :first_name, :last_name, :emergency_name, :emergency_relationship, presence: true, length: { maximum: 50 }
  validates :year, length: { maximum: 10 }
  validates :discipline, inclusion: { in: ['Engineering Science', 'Track One', 'Chemical', 'Civil', 'Computer', 'Electrical', 'Industrial', 'Material Science', 'Mechanical', 'Mineral'] }
  validates :leedurbus, :fweekbus, :tent, inclusion: { in: [true, false] }
  validates :email, presence: true, format: { with: VALID_UTMAIL_REGEX } 
  validates :emergency_email, presence: true, format: { with: VALID_EMAIL_REGEX } 
  validates :restrictions_dietary, :restrictions_misc,  length: { maximum: 2000 }
  validates :gender, inclusion: { in: ['Male', 'Female', '-'] }
  validates :emergency_phone, presence: true, length: { maximum: 25 }
  validates :phone, :emergency_phone, length: { maximum: 25 }
  validate  :hhf_package_is_available

  before_create :create_token
  before_create :set_default_data

  after_save :create_ticket_number

  before_save { self.email = email.downcase }

  default_scope order('created_at DESC')

  def exposed_data(opts={})
    data = attributes
    data.except!('confirmation_token') if opts[:hide_confirmation_token]
    data.merge! credit_info if opts[:show_credit_info]

    data['phone'] = Leedur.formatted_phone phone unless phone.blank?
    data['emergency_phone'] = Leedur.formatted_phone emergency_phone unless emergency_phone.blank?

    data
  end

  def self.formatted_phone(phone_international)
      number = GlobalPhone.parse phone_international
      (number and number.territory.name == 'US') ? number.national_format : phone_international
  end

  def self.formatted_date(date_time)
    date_time.to_time.in_time_zone(Rails.application.config.time_zone).strftime('%b %e, %Y')
  end

  def set_default_data
    self.verified = false
    self.checked_in = false
    true
  end

  def create_token
    self.confirmation_token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def create_ticket_number
    unless ticket_number
      self.ticket_number = (id.to_i * 100) + rand(100) + 100_000
      self.save!
      hhf_package.increase_count if self.fweekbus or self.leedurbus
    end
  end

  def set_random_gender_disc
    disps = ['Engineering Science', 'Track One', 'Chemical', 'Civil', 'Computer', 'Electrical', 'Industrial', 'Material Science', 'Mechanical', 'Mineral']
    genders = ['Male', 'Female']
    self.gender = genders[rand genders.count]
    self.discipline = disps[rand disps.count]
  end


  def send_email(opts)
    message = {
     subject: opts[:subject],
     from_name: 'F!rosh Week 1T6',
     html: ERB.new(File.read(Rails.root.join(opts[:html_body]))).result(binding),
     to: [
       {
         email: email,
         name: "#{first_name} #{last_name}"
       }
     ],
     from_email: opts[:from_email]
    }
    Mandrill::API.new.messages.send message
  end

  def send_confirmation
    send_email({
      subject: 'Please confirm your email',
      html_body: 'app/views/email_leedur_confirm.html.erb',
      from_email: Rails.application.config.mandrill_from
    })
  end

  def send_receipt
    send_email({
      subject: 'Your receipt and ticket',
      html_body: 'app/views/email_leedur_receipt.html.erb',
      from_email: Rails.application.config.mandrill_from
    })
  end

  def process_payment(token)
    # Create the charge on Stripe's servers - this will charge the user's card
    begin
      charge = create_stripe_charge token

      self.charge_id = charge["id"]
      self.save!

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

  def create_stripe_charge(token)
    Stripe::Charge.create(
      amount: hhf_package.price * 100, # amount in cents
      currency: 'cad',
      card: token,
      description: email,
    )
  end

  def hhf_package_is_available
      #if ticket is already created means that package has already been 
    unless self.ticket_number || hhf_package.available? || is_created_by_admin?
      errors.add(:hhf_package, "Package is no longer available")
    end
  end

  def is_created_by_admin?
    !created_by_admin.blank?
  end
    
  def get_confirm_url
    'http://' + Rails.application.config.hostname + '/leedurs_adventures/confirm/' + id.to_s + '/' + confirmation_token
  end

  def get_billing_last4
    return nil unless charge_id
    Stripe::Charge.retrieve(charge_id)["source"]["last4"]
  end

  def get_billing_name
    return nil unless charge_id
    Stripe::Charge.retrieve(charge_id)["source"]["name"]
  end

  def get_billing_type
    return nil unless charge_id
    Stripe::Charge.retrieve(charge_id)["source"]["brand"]
  end

  def credit_info
    return {} unless charge_id
    print "Here\n"
    print charge_id
    print "\n"
    card_details = Stripe::Charge.retrieve(charge_id)
    print card_details.inspect
    print "\n"
    card = Stripe::Charge.retrieve(charge_id)["source"]
    {
      cc_name: card["name"],
      cc_last4: card["last4"],
      cc_type: card["brand"],
    }
  end

end
