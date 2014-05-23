# == Schema Information
#
# Table name: merchants
#
#  id             :integer          not null, primary key
#  name           :string(255)
#  permalink      :string(255)
#  deleted_at     :datetime
#  created_at     :datetime
#  updated_at     :datetime
#  merchant_email :string(255)
#

require 'spec_helper'

describe FoxYam::Merchant do
  let(:merchant) { Factories::Merchant.mock }
  let(:user) { Factories::User.mock }
  before { merchant.hires user }
  describe '#primary_email' do
    subject { merchant.primary_email }
    specify { should eq user.email }
  end
  describe '#company_with_default' do
    subject { -> { merchant.company_with_default } }
    specify { should change(FoxYam::Company, :count).by 1 }
    specify { should change(FoxYam::Contact, :count).by 1 }
  end
end
