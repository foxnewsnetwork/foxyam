require 'spec_helper'

describe Negotiations::EmailCompanies::Interactor do
  let(:negotiation) { Factories::Negotiation.mock }
  let(:email) { Factories::Email.mock }
  let(:raw_interactor) { Negotiations::EmailCompanies::Interactor.new negotiation, email }
  let(:interactor) { raw_interactor.tap { |i| i.attributes = @params } }
  let(:result) { interactor.company_negotiation_offer! }
  let(:offer) { interactor.offer }
  let(:conversation) { interactor.conversation }
  let(:company) { interactor.company }
  context 'new company' do
    before do
      @params = {
        company_name: 'Akagami feat. GUMI',
        offer_type: "buy"
      }
    end
    describe '#company_negotiation_offer!' do
      it 'should be successful' do
        result.should be_success
      end
      it 'should be valid' do
        interactor.should be_valid
        interactor.offer_type.should eq 'buy'
        interactor.errors.should be_empty
      end
      it 'should create an offer' do
        expect { result }.to change(negotiation.offers, :count).by 1
      end
      it 'should create a new company' do
        expect { result }.to change(FoxYam::Company, :count).by 1
      end
      it 'should create a conversation' do
        expect { result }.to change(FoxYam::Conversation, :count).by 1
      end
    end
    context 'auxiliaries' do
      before { result }
      it 'should have a proper offer' do
        offer.should be_a FoxYam::Offer
        offer.should be_persisted
        offer.negotiation.should eq negotiation
        offer.conversations.should include conversation
      end
      it 'should create a proper conversation' do
        conversation.should be_a FoxYam::Conversation
        conversation.should be_persisted
        conversation.company.should eq company
      end
      it 'should create a company' do
        company.should be_a FoxYam::Company
        company.should be_persisted
        company.should eq offer.company
      end
    end
  end
end