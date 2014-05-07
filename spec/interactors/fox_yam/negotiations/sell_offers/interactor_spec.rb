require 'spec_helper'

describe FoxYam::Negotiations::SellOffers::Interactor do
  let(:raw_interactor) { described_class.new negotiation: negotiation, merchant: merchant }
  let(:negotiation) { Factories::Negotiation.mock }
  let(:merchant) { Factories::Merchant.mock }
  let(:interactor) { raw_interactor.tap { |i| i.attributes = @params } }
  let(:result) { interactor.offer! }
  before do
    @params = {
      tag_type: 'price',
      place_name: 'Hong Kong Port',
      usd_per_pound: 2.44,
      incoterm: 'CIF'
    }
  end
  describe '#offer!' do
    specify { expect { result }.to change(FoxYam::Offer, :count).by 1 }
    specify { expect { result }.to change(FoxYam::Conversation, :count).by 1 }
    specify { expect { result }.to change(FoxYam::Company, :count).by 1 }
  end
  context 'relationships' do
    before { result }
    it 'company should be different' do
      negotiation.merchant.companies.should_not include interactor.offer.company
    end
  end
end