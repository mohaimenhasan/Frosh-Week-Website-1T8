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

require 'spec_helper'

describe User do

  before { @user = User.new ({
    email: 'me@amandeep.ca',
    discipline: 'Engineering Science',
    emergency_name: 'Captain Kirk',
    emergency_phone: '416 967 1111',
    emergency_relationship: 'Captain',
    emergency_email: 'tester@gmail.com',
    first_name: 'Amandeep',
    last_name: 'Grewal',
    phone: '416 555 5555',
    residence: 'Home',
    restrictions_dietary: 'I eat ALL the things!',
    restrictions_misc: 'I prefer to meet no new people',
    shirt_size: 'Medium',
    gender: 'Male',
    verified: false,
    bursary_requested: false,
    ticket_number: '1234546'
  })}

  subject { @user }

  it { should respond_to(:email) }
  it { should respond_to(:discipline) }
  it { should respond_to(:emergency_name) }
  it { should respond_to(:emergency_phone) }
  it { should respond_to(:emergency_relationship) }
  it { should respond_to(:first_name) }
  it { should respond_to(:group) }
  it { should respond_to(:last_name) }
  it { should respond_to(:phone) }
  it { should respond_to(:residence) }
  it { should respond_to(:restrictions_dietary) }
  it { should respond_to(:restrictions_misc) }
  it { should respond_to(:shirt_size) }
  it { should respond_to(:verified) }

  describe 'when discipline is not present' do
    before { @user.discipline = ' ' }
    it {should_not be_valid }
  end

  describe 'when first_name is not present' do
    before { @user.first_name = ' ' }
    it {should_not be_valid }
  end

  describe 'when emergency_name is not present' do
    before { @user.emergency_name = ' ' }
    it {should_not be_valid }
  end

  describe 'when emergency_relationship is not present' do
    before { @user.emergency_relationship = ' ' }
    it {should_not be_valid }
  end

  describe 'when emergency_phone is not present' do
    before { @user.emergency_phone = ' ' }
    it {should_not be_valid }
  end

  describe 'when last_name is not present' do
    before { @user.last_name = ' ' }
    it {should_not be_valid }
  end

  describe 'when email is not present' do
    before { @user.email = ' ' }
    it {should_not be_valid }
  end

  describe 'when phone is not present' do
    before { @user.phone = ' ' }
    it {should be_valid }
  end

  describe 'when shirt_size is not present' do
    before { @user.shirt_size = ' ' }
    it {should_not be_valid }
  end

  describe 'when verified is not present' do
    before { @user.verified = ' ' }
    it {should_not be_valid }
  end

  describe 'when discipline is too long' do
    before { @user.discipline = 'a' * 51 }
    it {should_not be_valid }
  end

  describe 'when first_name is too long' do
    before { @user.first_name = 'a' * 51 }
    it {should_not be_valid }
  end

  describe 'when emergency_name is too long' do
    before { @user.emergency_name = 'a' * 51 }
    it {should_not be_valid }
  end

  describe 'when emergency_relationship is too long' do
    before { @user.emergency_relationship = 'a' * 51 }
    it {should_not be_valid }
  end

  describe 'when last_name is too long' do
    before { @user.last_name = 'a' * 51 }
    it {should_not be_valid }
  end

  describe 'when residence is too long' do
    before { @user.residence = 'a' * 51 }
    it {should_not be_valid }
  end

  describe 'when restrictions_dietary is too long' do
    before { @user.restrictions_dietary = 'a' * 2001 }
    it {should_not be_valid }
  end

  describe 'when restrictions_misc is too long' do
    before { @user.restrictions_misc = 'a' * 2001 }
    it {should_not be_valid }
  end

  describe 'when email format is invalid' do
    it 'should be invalid' do
      addresses = %w[user@foo,com user_at_foo.org example.user@foo. foo@bar_baz.com foo@bar+baz.com]
      addresses.each do |invalid_address|
        @user.email = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe 'when email format is valid' do
    it 'should be valid' do
      addresses = %w[user@foo.COM A_US-ER@f.b.org frst.lst@foo.jp a+b@baz.cn]
      addresses.each do |valid_address|
        @user.email = valid_address
        @user.should be_valid
      end
    end
  end

  describe 'when phone format is invalid' do
    it 'should be invalid' do
      addresses = ['416967111', '41696711111', '416-967-11x11', '(4416) 967-1111', '(4x16) 967-1111']
      addresses.each do |invalid_address|
        @user.phone = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe 'when emergency_phone format is invalid' do
    it 'should be invalid' do
      addresses = ['416967111', '41696711111', '416-967-11x11', '(4416) 967-1111', '(4x16) 967-1111']
      addresses.each do |invalid_address|
        @user.emergency_phone = invalid_address
        @user.should_not be_valid
      end
    end
  end

  describe 'when phone/emergency_phone format is valid' do
    it 'should be valid' do
      addresses = ['416-967-1111', '(416) 967-1111', '(416) 9671111', '(416) 967 1111', '(416) 967.1111', '416.967.1111' ,'4169671111', '416 967 1111', '+1 416 967 1111', '1 416 967 1111', '14169671111']
      addresses.each do |valid_address|
        @user.phone = valid_address
        @user.emergency_phone = valid_address
        @user.should be_valid
      end
    end
  end

end
