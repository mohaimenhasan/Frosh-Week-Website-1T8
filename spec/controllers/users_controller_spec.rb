require 'spec_helper'

describe Api::UsersController do

  before do
    Rails.application.config.hostname = "test.com"
  end

  describe "POST create" do

    context "with valid attributes requesting bursary" do

      it "creates a new user" do
        expect_valid_new_user FactoryGirl.attributes_for :bursary_requested_user
      end

      context "creates multiple users" do

        it "increments ticket by ~100" do
          user_attr1 = FactoryGirl.attributes_for :bursary_requested_user
          user_attr2 = FactoryGirl.attributes_for :bursary_requested_user

          except_incrementing_ticket_numbers user_attr1, user_attr2
        end
      end
    end

    context "with valid attributes" do

      it "creates a new user" do
        User.any_instance.expects(:create_stripe_charge).returns("id" => "charge_tok_1")
        User.any_instance.expects(:credit_info).returns fake_credit_info

        expect_valid_new_user FactoryGirl.attributes_for :paying_user
        expect(User.last.reload.charge_id).to eq "charge_tok_1"
      end

      context "creates multiple users" do

        it "increments ticket by ~100" do
          User.any_instance.expects(:create_stripe_charge).twice.returns({"id" => "charge_tok_1"}, {"id" => "charge_tok_2"})
          User.any_instance.expects(:credit_info).twice.returns fake_credit_info

          user_attr1 = FactoryGirl.attributes_for :paying_user
          user_attr2 = FactoryGirl.attributes_for :paying_user

          except_incrementing_ticket_numbers user_attr1, user_attr2
          expect(User.last.reload.charge_id).to eq "charge_tok_2"
          expect(User.last(2).first.reload.charge_id).to eq "charge_tok_1"
        end
      end
    end
  end

  describe "PUT update" do

    before do
      User.any_instance.expects(:send_confirmation)
    end

    context "for bursary requesting user" do

      before do
        User.any_instance.expects(:send_receipt).never
      end

      it "successfully confirm user" do
        User.any_instance.expects(:credit_info).twice.returns fake_credit_info

        post :create, { user: FactoryGirl.attributes_for(:bursary_requested_user) }
        expect_verification User.last.reload
      end

      it "fail to confirm user" do
        User.any_instance.expects(:credit_info).returns fake_credit_info

        post :create, { user: FactoryGirl.attributes_for(:bursary_requested_user) }
        expect_no_verification User.last.reload
      end
    end

    context "for paying user" do

      before do
        User.any_instance.expects(:create_stripe_charge).returns("id" => "charge_tok_1")
      end

      it "successfully confirm user" do
        User.any_instance.expects(:send_receipt)
        User.any_instance.expects(:credit_info).twice.returns fake_credit_info

        post :create, { user: FactoryGirl.attributes_for(:paying_user) }
        expect_verification User.last.reload
      end

      it "fail to confirm user" do
        User.any_instance.expects(:credit_info).returns fake_credit_info

        post :create, { user: FactoryGirl.attributes_for(:paying_user) }
        expect_no_verification User.last.reload
      end
    end
  end
end

def fake_credit_info
{
  cc_name: "name",
  cc_last4: "last4",
  cc_type: "type",
}
end

def expect_valid_new_user(user_attr)
  User.any_instance.expects(:send_confirmation)

  user_count = User.count
  post :create, { user: user_attr }
  expect(User.count).to eq(user_count + 1)

  expect_valid_user user_attr, User.last.reload
end

def expect_valid_user(user_attr, user)
  expect(user_attr[:first_name]).to eq user.first_name
  expect(user_attr[:last_name]).to eq user.last_name
  expect(user.confirmation_token).not_to eq nil
  expect(user.ticket_number).not_to eq nil
  expect(user.group_id).not_to eq nil
  expect(user.verified).to eq false
  expect(user.bursary_chosen).to eq nil
  expect(user.bursary_paid).to eq false
end

def except_incrementing_ticket_numbers(user_attr1, user_attr2)
  User.any_instance.expects(:send_confirmation).twice

  post :create, { user: user_attr1 }
  user1 = User.last.reload
  expect_valid_user user_attr1, user1
  post :create, { user: user_attr2 }
  user2 = User.last.reload
  expect_valid_user user_attr2, user2

  first_ticket_number = (user1.ticket_number.to_i - 100_000) / 100;
  second_ticket_number = (user2.ticket_number.to_i - 100_000) / 100;

  expect(second_ticket_number).to eq(first_ticket_number + 1)
end

def expect_verification(user)
  expect(User.last.reload.verified).to be false
  put :update, { id: user.id, user: user.attributes.merge({ verified:true }) }
  expect(User.last.reload.verified).to be true
end

def expect_no_verification(user)
  expect(User.last.reload.verified).to be false
  put :update, { id: user.id, user: user.attributes.merge({ verified:true, confirmation_token: 'blahblahblah' }) }
  expect(User.last.reload.verified).to be false
end
