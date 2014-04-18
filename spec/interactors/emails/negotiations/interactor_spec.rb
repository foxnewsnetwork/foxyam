require 'spec_helper'

describe Emails::Negotiations::Interactor do
  let(:raw_interactor) { Emails::Negotiations::Interactor.new @email, merchant }
  let(:interactor) { raw_interactor.tap { |i| i.attributes = @params } }
  let(:inbox) { @email.inbox }
  let(:account) { inbox.account }
  let(:merchant) { account.merchant }
  let(:result) { interactor.negotiation! }
  let(:conversation) { @email.conversation }
  let(:offer) { conversation.offer }
  let(:negotiation) { offer.negotiation }
  before do
    @email = Factories::Email.mock
    @negotiation = Factories::Negotiation.belongs_to(merchant).mock
  end
  context 'factories' do
    it 'should create an email' do
      @email.should be_a FoxYam::Email
      @email.should be_persisted
    end

    it 'should have a correct inbox' do
      inbox.should be_a FoxYam::EmailInbox
      inbox.should be_persisted
    end

    it 'should have the correct account' do
      account.should be_a FoxYam::EmailAccount
      account.should be_persisted
    end

    it 'should all belong to the correct merchant' do
      merchant.should be_a FoxYam::Merchant
      merchant.should be_persisted
    end
    it 'should be a persisted negotiation' do
      @negotiation.should be_a FoxYam::Negotiation
      @negotiation.should be_persisted
      @negotiation.merchant.should eq merchant
      merchant.all_negotiations.should include @negotiation
    end
  end
  context 'permalink existing #negotiation!' do

    before do
      @params = { permalink: @negotiation.id }
      result
    end
    it 'should generate a successful result' do
      result.should be_success
    end
    it 'should be new' do
      interactor.should_not be_new
    end
    it 'should not be existing' do
      interactor.should be_existing
    end
    it 'should have generated correct negotiation' do
      interactor.negotiation.should be_a FoxYam::Negotiation
      interactor.negotiation.should be_persisted
      
    end
  end
  context 'permalink new #negotiation!' do
    
    before do 
      @params = { permalink: :new }
      result
    end
    it 'should generate a successful result' do
      result.should be_success
    end
    it 'should be new' do
      interactor.should be_new
    end
    it 'should not be existing' do
      interactor.should_not be_existing
    end
    it 'should have generated correct negotiation' do
      negotiation.should be_a FoxYam::Negotiation
      negotiation.should be_persisted
      negotiation.offers.should include offer
      negotiation.merchant.should eq merchant
    end
    it 'should have created a proper offer' do
      offer.should be_a FoxYam::Offer
      offer.should be_persisted
      offer.conversations.should include conversation
      offer.company.should be_blank
    end
    it 'should create a proper conversation' do
      conversation.should be_a FoxYam::Conversation
      conversation.should be_persisted
      conversation.email.should eq @email
      conversation.company.should be_blank
    end
  end
end