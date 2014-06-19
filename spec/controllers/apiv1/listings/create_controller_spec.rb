require 'spec_helper'

describe Apiv1::Listings::CreateController do
  login_merchant
  let(:create) { post :create, listing: @params, format: :json }
  before do
    @params = { 
      "material_name"=>"Onie",
      "is_private"=>false,
      "asking_price"=>0.35,
      "price_unit"=>"pound",
      "incoterm"=>"FAS",
      "location_name"=>"North Jane",
      "quantity"=>4,
      "quantity_unit"=>"containers",
      "packing_weight"=>36000,
      "transportor"=>"40ST", 
      "time_interval"=>"one-time"
    }
  end
  context '#create' do
    subject { lambda { create } }
    specify { should change(FoxYam::Negotiation, :count).by 1 }
    specify { should change(FoxYam::Conversation, :count).by 1 }
    specify { should change(FoxYam::Offer, :count).by 1 }
    specify { should change(FoxYam::Conversations::Material, :count).by 1 }
    specify { should change(FoxYam::Conversations::Price, :count).by 1 }
    specify { should change(FoxYam::Conversations::PackingWeight, :count).by 1 }
    specify { should change(FoxYam::Conversations::Quantity, :count).by 1 }
  end
  context 'responses' do
    before { create }
    let(:interactor) { controller.send :_interactor }
    let(:attributes) { interactor.to_builder.attributes! }
    let(:json) { JSON.parse(response.body) }
    specify { response.should be_success }
    specify { response.content_type.should eq "application/json" }
    specify { interactor.to_builder.should be_a Jbuilder }
    it "should have all the matching keys and values of the crap in params" do
      @params.each do |key, value|
        attributes[key].should eq value
      end
    end
    specify { attributes["id"].should > 0 }
    specify { attributes["conversation_id"].should > 0 }
    specify { json["listing"].should be_present }
    specify { json["listing"].should eq attributes }
  end
end