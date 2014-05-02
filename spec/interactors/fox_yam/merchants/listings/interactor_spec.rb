require 'spec_helper'

describe FoxYam::Merchants::Listings::Interactor do
  let(:raw_interactor) { described_class.new merchant }
  let(:merchant) { Factories::Merchant.mock }
  let(:interactor) { raw_interactor.tap { |i| i.attributes = @params } }
  let(:result) { interactor.listing! }
  before do
    @params = {
      material: 'High Quality Dog Food',
      place_name: 'Oakland Port, CA',
      negotiation_type: 'merchant_is_selling',
      privatize: true
    }
  end
  describe '#listing' do
    it 'should create a company' do
      expect { result }.to change(FoxYam::Company, :count).by 1
    end
    it 'should create a conversation' do
      expect { result }.to change(FoxYam::Conversation, :count).by 1
    end
    it 'should create a offer' do
      expect { result }.to change(FoxYam::Offer, :count).by 1
    end
    it 'should create an negotiation' do
      expect { result }.to change(FoxYam::Negotiation, :count).by 1
    end
    it 'should create a material tag' do
      expect { result }.to change(FoxYam::Conversations::Material, :count).by 1
    end
  end
  context 'relationships' do
    before { result }
    specify { interactor.should be_valid }
    specify { interactor.should be_present }
    specify { interactor.offer.should be_present }
    specify { interactor.offer.negotiation.should eq interactor.negotiation }
    specify { interactor.offer.conversations.should include interactor.conversation }
    specify { interactor.company.company_name.should eq interactor.merchant.name }
    specify { interactor.conversation.materials.should be_present }
    specify { interactor.conversation.materials.first.material.should eq @params[:material] }
    specify { interactor.negotiation.should be_sale_type }
    specify { interactor.negotiation.merchant.should eq merchant }
  end
end