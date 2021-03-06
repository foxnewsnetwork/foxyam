# == Schema Information
#
# Table name: negotiations
#
#  id               :integer          not null, primary key
#  merchant_id      :integer
#  deleted_at       :datetime
#  dead_at          :datetime
#  finalized_at     :datetime
#  completed_at     :datetime
#  created_at       :datetime
#  updated_at       :datetime
#  public_at        :datetime
#  negotiation_type :string(255)
#

require 'spec_helper'

describe FoxYam::Negotiation do
  let(:negotiation) { Factories::Negotiation.mock }
  let(:merchant) { negotiation.merchant }
  let(:company) { merchant.companies.create! company_name: merchant.name }
  let(:offer) { negotiation.offers.create! company: company }
  describe '#merchant_default_offer' do
    before { offer }
    specify { negotiation.merchant_default_offers.should include offer }
    specify { negotiation.merchant_default_offer.should eq offer }
    specify { negotiation.merchant_default_offers.should be_present }
    specify { offer.should be_a FoxYam::Offer }
    specify { offer.should be_persisted }
    specify { company.offers.should be_present }
    specify { company.offers.should include offer }
  end
end
