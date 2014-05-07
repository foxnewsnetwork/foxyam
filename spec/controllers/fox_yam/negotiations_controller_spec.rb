require 'spec_helper'

describe FoxYam::NegotiationsController do
  let(:merchant) { controller.send :current_merchant }
  let(:user) { controller.send :current_user }
  context 'factories and sessions' do
    login_merchant
    it 'should properly be logged in' do
      merchant.should be_a FoxYam::Merchant
      merchant.should be_persisted
    end
    it 'should have created a user' do
      user.should be_a FoxYam::User
      user.should be_persisted
    end
    it 'should be signed in' do
      controller.send(:user_signed_in?).should be_true
    end
  end
  context 'anonymous' do
    let(:negotiation) { Factories::Negotiation.mock }
    before do
      get :show, id: negotiation.id
    end
    it 'should render properly' do
      response.should redirect_to new_user_session_path(back: request.path)
    end
  end
  context 'correct permission' do
    login_merchant
    let(:negotiation) { Factories::Negotiation.belongs_to(merchant).mock }
    before do
      get :show, id: negotiation.id
    end
    it 'should render properly' do
      response.should be_success
    end
  end
  context 'should redirect' do
    login_merchant
    let(:negotiation) { Factories::Negotiation.mock }
    before do
      get :show, id: negotiation.id
    end
    it 'should redirect' do
      response.should redirect_to welcome_unauthorized_path(target: request.path)
    end
  end
  context 'it should show public junk' do
    login_merchant
    let(:negotiation) { Factories::Negotiation.mock }
    before do
      negotiation.update public_at: DateTime.now
      get :show, id: negotiation.id
    end
    it 'should redirect' do
      response.should be_success
    end
  end
end