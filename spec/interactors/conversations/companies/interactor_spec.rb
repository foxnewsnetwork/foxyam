require 'spec_helper'

describe Conversations::Companies::Interactor do
  let(:raw_interactor) { Conversations::Companies::Interactor.new conversation }
  let(:interactor) { raw_interactor.tap { |i| i.attributes = @params } }
  let(:conversation) { Factories::Conversations::Companies::Interactor.new.conversation }
  let(:result) { interactor.conversation! }
  before do
    @params = {
      company_name: Faker::Company.name,
      offer_type: :sell
    }
  end
  context 'factories' do
    it 'should generate a reasonable conversation' do
      conversation.should be_a FoxYam::Conversation
    end
  end
  describe '#conversation!' do
    it "should create a company" do
      result.should be_success
    end
    it 'should create a contact' do
      expect { result }.to change(FoxYam::Contact, :count).by(1)
    end
    it 'should create a company' do
      expect { result }.to change(FoxYam::Company, :count).by(1)
    end
  end
  context 'auxiliaries' do
    let(:company) { interactor.company }
    let(:merchant) { interactor.merchant }
    let(:negotiation) { interactor.negotiation }
    let(:conversations) { company.conversations }
    let(:contacts) { interactor.instance_variable_get :@contacts }
    before { result }
    it 'should be a proper company' do
      company.should be_a FoxYam::Company
      company.should be_persisted
      conversation.company.should eq company
    end
    it 'should have a converation that correctly references the company id' do
      conversation.company_id.should eq company.id
    end
    it 'should have a proper merchant' do
      merchant.should be_a FoxYam::Merchant
      merchant.should be_persisted
      merchant.all_negotiations.should include negotiation
    end
    it 'should be a part of the conversation' do
      c = FoxYam::Company.find company.id
      c.conversations.should include conversation
    end
    it 'should have contacts that are properly tied' do
      contacts.each do |contact|
        contact.company.should eq company
      end
    end
  end
end