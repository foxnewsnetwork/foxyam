require 'spec_helper'

describe Apiv1::Listings::Interactor do
  let(:merchant) { Factories::Merchant.mock }
  let(:interactor) { described_class.new(merchant) }
  let(:creative) { interactor.tap { |i| i.attributes = @params } }
  let(:result) { creative.make_listing! }
  before do
    @params = {
      material_name: "Cow Boots",
      is_private: false,
      asking_price: 0.33,
      price_unit: "pound",
      incoterm: "FAS",
      location_name: "Long Beach Port", 
      quantity: 5,
      quantity_unit: "containers", 
      packing_weight: 34000,
      transportor: "pounds",
      time_interval: "one-time"
    }
  end
  context 'shoddy #make_listing!' do
    subject { lambda { interactor.make_listing! } }
    specify { should change(FoxYam::Conversations::Price, :count).by 0 }
    specify { should change(FoxYam::Conversations::Material, :count).by 0 }
    specify { should change(FoxYam::Conversations::Quantity, :count).by 0 }
    specify { should change(FoxYam::Conversations::PackingWeight, :count).by 0 }
    specify { should change(FoxYam::Negotiation, :count).by 0 }
    specify { should change(FoxYam::Conversation, :count).by 0 }
  end
  context 'checks' do
    specify { creative.should be__has_price }
    specify { creative.should be__has_quantity }
    specify { creative.should be__has_packing }
  end
  context '#result' do
    specify { result.should be_success }
    specify { result.payload.should be_present }
  end
  context '#_negotiation' do
    subject { creative.send :_negotiation }
    specify { should be_a FoxYam::Negotiation }
  end

  context '#make_listing!' do
    subject { lambda { creative.make_listing! } }
    specify { should change(FoxYam::Conversations::Price, :count).by 1 }
    specify { should change(FoxYam::Conversations::Material, :count).by 1 }
    specify { should change(FoxYam::Conversations::Quantity, :count).by 1 }
    specify { should change(FoxYam::Conversations::PackingWeight, :count).by 1 }
    specify { should change(FoxYam::Negotiation, :count).by 1 }
    specify { should change(FoxYam::Conversation, :count).by 1 }
  end
end