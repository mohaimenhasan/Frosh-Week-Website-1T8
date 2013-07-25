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

require 'spec_helper'
require 'awesome_print'

describe User do

  before { @user = FactoryGirl.build :user }

  subject { @user }

  describe 'when everything present' do
    it { should be_valid }
  end

  describe 'when mandatory first_name is not present' do
    before { @user.first_name = ' ' }
    it { should_not be_valid }
  end

  describe 'when mandatory last_name is not present' do
    before { @user.last_name = ' ' }
    it { should_not be_valid }
  end

  describe 'when mandatory discipline is not present' do
    before { @user.discipline = ' ' }
    it { should_not be_valid }
  end

  describe 'when mandatory emergency_name is not present' do
    before { @user.emergency_name = ' ' }
    it { should_not be_valid }
  end

  describe 'when mandatory emergency_relationship is not present' do
    before { @user.emergency_relationship = ' ' }
    it { should_not be_valid }
  end

  describe 'when mandatory emergency_phone is not present' do
    before { @user.emergency_phone = ' ' }
    it { should_not be_valid }
  end

  describe 'when mandatory email is not present' do
    before { @user.email = ' ' }
    it { should_not be_valid }
  end

  describe 'when mandatory shirt_size is not present' do
    before { @user.shirt_size = ' ' }
    it { should_not be_valid }
  end

  describe 'when mandatory gender is not present' do
    before { @user.gender = ' ' }
    it { should_not be_valid }
  end

  context 'when bursary_requested' do

    before do
      @user.bursary_requested = true
      @user.bursary_engineering_motivation = Faker::Lorem.sentence
      @user.bursary_financial_reasoning = Faker::Lorem.sentence
      @user.bursary_paid = true
      @user.bursary_osap = true
    end

    describe 'when everything present' do
      it { should be_valid }
    end

    describe 'when mandatory bursary_engineering_motivation is not present' do
      before { @user.bursary_engineering_motivation = ' ' }
      it { should_not be_valid }
    end

    describe 'when mandatory bursary_financial_reasoning is not present' do
      before { @user.bursary_financial_reasoning = ' ' }
      it { should_not be_valid }
    end

    describe 'when mandatory bursary_paid is not present' do
      before { @user.bursary_paid = ' ' }
      it { should_not be_valid }
    end

    describe 'when mandatory bursary_osap is not present' do
      before { @user.bursary_osap = ' ' }
      it { should_not be_valid }
    end

  end

  describe 'when discipline is too long' do
    before { @user.discipline = 'a' * 51 }
    it { should_not be_valid }
  end

  describe 'when first_name is too long' do
    before { @user.first_name = 'a' * 51 }
    it { should_not be_valid }
  end

  describe 'when emergency_name is too long' do
    before { @user.emergency_name = 'a' * 51 }
    it { should_not be_valid }
  end

  describe 'when emergency_relationship is too long' do
    before { @user.emergency_relationship = 'a' * 51 }
    it { should_not be_valid }
  end

  describe 'when last_name is too long' do
    before { @user.last_name = 'a' * 51 }
    it { should_not be_valid }
  end

  describe 'when residence is too long' do
    before { @user.residence = 'a' * 51 }
    it { should_not be_valid }
  end

  describe 'when restrictions_dietary is too long' do
    before { @user.restrictions_dietary = 'a' * 2001 }
    it { should_not be_valid }
  end

  describe 'when restrictions_misc is too long' do
    before { @user.restrictions_misc = 'a' * 2001 }
    it { should_not be_valid }
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

  context 'when creating multiple users' do

    describe 'when email address is already taken' do
      before do
        user_with_same_email = @user.dup
        user_with_same_email.save
      end

      it { should_not be_valid }
    end

    describe 'when email address (upcase) is already taken' do
      before do
        user_with_same_email = @user.dup
        user_with_same_email.email = @user.email.upcase
        user_with_same_email.save
      end

      it { should_not be_valid }
    end

    it 'should increment ticket_number by ~100' do
      user = @user
      user2 = FactoryGirl.build :user

      user.save!
      user2.save!

      first_ticket_number = (user.ticket_number.to_i - 100_000) / 100;
      second_ticket_number = (user2.ticket_number.to_i - 100_000) / 100;

      expect(second_ticket_number).to eq(first_ticket_number + 1)
    end

    it 'should balance groups if identical users sign up' do
      FactoryGirl.create_list(:user, Group.count * 3)

      num_users = Group.first.users.count
      Group.find_each do |g|
        expect(g.users.count).to eq num_users
      end
    end

    it 'should balance groups if num_groups*constant females sign up' do
      FactoryGirl.create_list(:user, Group.count - 5, gender: 'Female')
      FactoryGirl.create_list(:user, Group.count, gender: 'Male')
      FactoryGirl.create_list(:user, Group.count - 15, gender: 'Female')
      FactoryGirl.create_list(:user, Group.count, gender: 'Male')
      FactoryGirl.create_list(:user, Group.count + 20, gender: 'Female')

      num_females = Group.first.users.where(gender: 'Female').count
      num_males = Group.first.users.where(gender: 'Male').count
      expect(num_males * 3).to eq(num_females * 2)
      Group.find_each do |g|
        expect(g.users.where(gender: 'Female').count).to eq num_females
        expect(g.users.where(gender: 'Male').count).to eq num_males
      end
    end

    it 'should balance groups if num_groups*constant of specific discipline sign up' do
      FactoryGirl.create_list(:user, Group.count - 5, discipline: 'Electrical')
      FactoryGirl.create_list(:user, Group.count, discipline: 'Civil')
      FactoryGirl.create_list(:user, Group.count - 15, discipline: 'Electrical')
      FactoryGirl.create_list(:user, Group.count, discipline: 'Civil')
      FactoryGirl.create_list(:user, Group.count + 20, discipline: 'Electrical')

      num_elec = Group.first.users.where(discipline: 'Electrical').count
      num_civ = Group.first.users.where(discipline: 'Civil').count
      expect(num_civ * 3).to eq(num_elec * 2)
      Group.find_each do |g|
        expect(g.users.where(discipline: 'Electrical').count).to eq num_elec
        expect(g.users.where(discipline: 'Civil').count).to eq num_civ
      end
    end

  end

  describe 'when saving' do

    it 'should have confirmation_token, ticket_number, group id' do
      @user.save!
      expect(@user.reload.confirmation_token).not_to eq nil
      expect(@user.reload.ticket_number).not_to eq nil
      expect(@user.reload.group_id).not_to eq nil
    end

    it 'should have default data' do
      @user.save!
      expect(@user.reload.verified).to eq false
      expect(@user.reload.bursary_chosen).to eq nil
      expect(@user.reload.bursary_paid).to eq false
    end

    it 'should keep existing ticket_number if it exists' do
      @user.save!
      ticket_number = @user.reload.ticket_number
      @user.save!
      expect(@user.reload.ticket_number).to eq ticket_number
    end
  end

  context 'when formatting' do

    it 'shoud format North American numbers' do
      expect(User.formatted_phone '4169671111').to eq '(416) 967-1111'
      expect(User.formatted_phone '416-967-1111').to eq '(416) 967-1111'
      expect(User.formatted_phone '416.967.1111').to eq '(416) 967-1111'
      expect(User.formatted_phone '416 967 1111').to eq '(416) 967-1111'
    end

    it 'shoud format dates' do
      expect(User.formatted_date '2013-07-25T08:51:04Z').to eq 'Jul 25, 2013'
      expect(User.formatted_date '2013-07-25T01:51:04Z').to eq 'Jul 24, 2013' #UTC to EST conversion
    end
  end

  context 'charging stripe' do

    it 'should create charge_id' do
      @user.expects(:create_stripe_charge).returns("id" => "charge_tok_1")

      result = @user.process_payment('tok_1')
      expect(result).to eq :success
    end
  end

end
