require 'spec_helper'

describe FoxYam::OffersController do
  context 'has permission' do
    context 'owner' do
      login_merchant
      let(:merchant) { controller.send :current_merchant }
      let(:negotiation) { Factories::Negotiation.belongs_to(merchant).mock }
      let(:offer) { Factories::Offer.belongs_to(negotiation).mock }
      before do
        get :show, id: offer.id
      end
      specify { offer.negotiation.should eq negotiation }
      specify { negotiation.merchant.should eq merchant }
      it 'should render correctly' do
        response.should be_success
      end
      it 'should render the right template' do
        response.should render_template 'fox_yam/offers/show'
      end
    end
    context 'offer-er' do
      login_merchant
      let(:merchant) { controller.send :current_merchant }
      let(:company) { merchant.company_with_default }
      let(:offer) { Factories::Offer.belongs_to(company).mock }
      before do
        get :show, id: offer.id
      end
      it 'should render correctly' do
        response.should be_success
      end
    end
  end
  context 'no permission' do
    login_merchant
    let(:merchant) { controller.send :current_merchant }
    let(:offer) { Factories::Offer.mock }
    before do
      get :show, id: offer.id
    end
    it 'should render correctly' do
      response.should redirect_to welcome_unauthorized_path(target: request.path)
    end
  end
end