require 'spec_helper'

describe FoxYam::Offers::Contracts::Interactor do
  let(:default_offer) { Factories::Conversation.full_mock.offer }
  let(:other_convo) { other_interactor.tap(&:offer!).conversation }
  let(:other_offer) { other_convo.offer }
  let(:other_interactor) { FoxYam::Negotiations::BuyOffers::Interactor.new(negotiation: negotiation, merchant: merchant) }
  let(:negotiation) { default_offer.negotiation }
  let(:merchant) { Factories::Merchant.mock }
  let(:interactor) { described_class.new other_offer }
  context 'factories shit' do
    let(:offer) { other_convo.tap { |c| Factories::Conversation.mock_tags c }.offer }
    it 'should have a given price' do
      offer.prices.should be_present
      p = offer.prices.first
      p.usd_per_pound.should be_present
    end
    specify { expect { other_offer }.to change(FoxYam::Conversations::Price, :count).by 1 }
    specify { expect { offer }.to change(FoxYam::Conversations::Price, :count).by 2 }
  end
  context 'other finalize' do
    let(:offer) { other_convo.tap { |c| Factories::Conversation.mock_tags c }.offer }
    let(:finalized) { FoxYam::Offers::Finalizes::Interactor.new(offer).tap { |i| i.agreed = true; i.finalize! }.offer }
    specify { expect { finalized }.to change(FoxYam::LineItem, :count).by 1 }
    specify { finalized.line_items.count.should > 0 }
    specify { finalized.line_items.map { |i| i.unit_price.should > 0 } }
    specify { finalized.line_items.map { |i| i.weight.should > 0 } }
  end
  context 'factories' do
    it 'should create both offers' do
      default_offer.should be_persisted
    end
    it 'should have an negotiation_id' do
      default_offer.negotiation_id.should be_present
    end
    it 'should both belong to the same offer' do
      negotiation.should be_present
    end
    it 'should successfully create the other offer' do
      other_offer.should be_persisted
    end
    it 'should both be the same negotiation' do
      negotiation.should eq other_offer.negotiation
    end
    it 'should match on names' do
      nmn = negotiation.merchant.name
      cmn = default_offer.company.name
      nmn.should_not =~ /FoxYam::/
      cmn.should_not =~ /FoxYam::/
      nmn.should eq cmn
    end
    specify { default_offer.offer_type.should eq 'sell' }
    specify { other_offer.offer_type.should eq 'buy' }
    specify { negotiation.offers.should include default_offer }
    specify { negotiation.merchant_default_offer.should eq default_offer }
    specify { default_offer.company.should eq negotiation.merchant.company_with_default }
  end
  context 'contract' do
    let(:contract) { interactor.contract }
    let(:results) { interactor.results }
    before do 
      Factories::Conversation.mock_tags other_convo
      FoxYam::Offers::Finalizes::Interactor.new(other_offer).tap { |i| i.agreed = true }.finalize!
      interactor.make_contract!
      @offer = FoxYam::Offer.find other_offer.id
    end
    specify { results.should be_a Array }
    specify { results.map { |result| result.should be_a Gtps::Result } }
    specify { results.map(&:payload).all? { |result| result.should be_present }.should be_true }
    specify { results.map { |result| result.should be_success } }
    it 'should not have any error messages' do
      results.select(&:failed?).each do |result|
        result.messages.should eq Hash.new
      end
    end
    it 'should have any failed' do
      results.select(&:failed?).count.should eq 0
    end
    specify { results.count.should > 8 }
    specify { @offer.line_items.count.should > 0 }
    specify { contract.should be_persisted }
    specify { contract.should be_a Gtps::Contract }
    specify { contract.documents.should be_present }
    specify { contract.items.should be_present }
    specify { contract.punishments.should be_present }
    specify { contract.transportation_requirements.should be_present }
  end
  context '#contract!' do
    let(:make_contract!) { interactor.make_contract! }
    before do
      Factories::Conversation.mock_tags other_convo
      FoxYam::Offers::Finalizes::Interactor.new(other_offer).tap { |i| i.agreed = true }.finalize!
    end
    specify { expect { make_contract! }.to change(Gtps::Item, :count).by 1 }
    specify { expect { make_contract! }.to change(Gtps::Document, :count).by 6 }
    specify { expect { make_contract! }.to change(Gtps::Party, :count).by 2 }
    specify { expect { make_contract! }.to change(Gtps::Punishment, :count).by 2 }
    specify { expect { make_contract! }.to change(Gtps::TransportationRequirement, :count).by 2 }
  end
  context 'validation' do
    it 'should be valid when mocked' do
      Factories::Conversation.mock_tags other_convo
      FoxYam::Offers::Finalizes::Interactor.new(other_offer).tap { |i| i.agreed = true }.finalize!
      interactor.should be_valid, interactor.errors_collection.messages_to_string
    end
    specify { interactor.should_not be_valid, interactor.errors_collection.messages_to_string }
  end
end