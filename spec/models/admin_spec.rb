# == Schema Information
#
# Table name: admins
#
#  id                :integer          not null, primary key
#  email             :string(255)
#  authorized_routes :text
#  created_at        :datetime         not null
#  updated_at        :datetime         not null
#

require 'spec_helper'

describe Admin do

  before { @user = FactoryGirl.build :user }

  subject { @user }

  describe 'when everything present' do
    it { should be_valid }
  end

end
