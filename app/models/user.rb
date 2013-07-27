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
#  bursary_engineering_motivation :text
#  bursary_financial_reasoning    :text
#  bursary_osap                   :boolean
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
                  :bursary_paid, :bursary_engineering_motivation, :bursary_financial_reasoning, :bursary_osap,
                  :confirmation_token, :verified,
                  :emergency_name, :emergency_phone, :emergency_relationship, :emergency_email,
                  :restrictions_dietary, :restrictions_accessibility, :restrictions_misc,
                  :charge_id, :ticket_number

  belongs_to :group
  belongs_to :package

  validates :first_name, :last_name, :emergency_name, :emergency_relationship, presence: true, length: { maximum: 50 }
  validates :discipline, inclusion: { in: ['Engineering Science', 'Track One', 'Chemical', 'Civil', 'Computer', 'Electrical', 'Industrial', 'Material Science', 'Mechanical', 'Mineral'] }
  validates :email, :emergency_email, presence: true, format: { with: VALID_EMAIL_REGEX } 
  validates :email, uniqueness: { case_sensitive: false }
  validates :shirt_size, inclusion: { in: ['Small', 'Medium', 'Large', 'Extra Large']}
  validates :bursary_chosen, inclusion: { in: [nil, true, false] }
  validates :bursary_requested, inclusion: { in: [true, false] }
  validates :bursary_engineering_motivation, :bursary_financial_reasoning, presence: true, length: { maximum: 2000 }, if: :bursary_requested?
  validates :bursary_osap, inclusion: { in: [true, false] }, if: :bursary_requested?
  validates :residence, length: { maximum: 50 }
  validates :restrictions_dietary, :restrictions_misc, :restrictions_accessibility, length: { maximum: 2000 }
  validates :gender, inclusion: { in: ['Male', 'Female', '-'] }
  validates :emergency_phone, presence: true, length: { maximum: 25 }
  validates :phone, :emergency_phone, length: { maximum: 25 }
  validates :emergency_phone, presence: true

  before_create :create_token
  before_create :assign_group
  before_create :set_default_data

  after_save :create_ticket_number

  before_save { self.email = email.downcase }

  def exposed_data(opts={})
    data = attributes
    data.except!('confirmation_token') if opts[:hide_confirmation_token]
    data.merge! credit_info if opts[:show_credit_info]

    data['phone'] = User.formatted_phone phone unless phone.blank?
    data['emergency_phone'] = User.formatted_phone emergency_phone unless emergency_phone.blank?

    data
  end

  def self.formatted_phone(phone_international)
      number = GlobalPhone.parse phone_international
      (number and number.territory.name == 'US') ? number.national_format : phone_international
  end

  def self.formatted_date(date_time)
    date_time.to_time.in_time_zone('Eastern Time (US & Canada)').strftime('%b %e, %Y')
  end

  def set_default_data
    self.verified = false

    self.bursary_chosen = nil
    self.bursary_paid = false

    true
  end

  def create_token
    self.confirmation_token = Digest::SHA1.hexdigest([Time.now, rand].join)
  end

  def create_ticket_number
    unless ticket_number
      self.ticket_number = (id.to_i * 100) + rand(100) + 100_000
      self.save!
    end
  end

  def set_random_gender_disc
    disps = ['Engineering Science', 'Track One', 'Chemical', 'Civil', 'Computer', 'Electrical', 'Industrial', 'Material Science', 'Mechanical', 'Mineral']
    genders = ['Male', 'Female']
    self.gender = genders[rand genders.count]
    self.discipline = disps[rand disps.count]
  end

  def assign_group
    empty_group = Group.includes(:users).where(users: { group_id: nil }).first
    self.group =
      if empty_group
        empty_group
      else
        Group.select("groups.name, groups.id, count(nullif(users.gender='" + gender + "', false)) AS gender_count, count(nullif(users.discipline='" + discipline + "', false)) AS disc_count, count(users.id) AS users_count").joins(:users).group('groups.name, groups.id').order('users_count ASC').order('gender_count ASC').order("disc_count ASC").first
      end

    #Useful method to check for group stats: Group.all.each {|g| p g.name.to_s << ": " << g.users.count.to_s << ", " << g.users.where(gender: 'Female').count.to_s << ", " << g.users.where(discipline:'Mineral').count.to_s}
  end

  def send_confirmation
    message = {
     subject: 'Please confirm your email',
     from_name: 'F!rosh Week 1T3',
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
     subject: 'Your receipt and ticket',
     from_name: 'F!rosh Week 1T3',
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
      charge = create_stripe_charge token

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

  def create_stripe_charge(token)
    Stripe::Charge.create(
      amount: package.price * 100, # amount in cents
      currency: 'cad',
      card: token,
      description: email,
    )
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
