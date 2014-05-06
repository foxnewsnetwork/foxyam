require 'spec_helper'

describe FoxYam::Negotiations::DeathsController do
  let(:negotiation) { Factories::Negotiation.mock }
  before do
    @create = lambda { post :create, negotiation_id: negotiation.id }
  end
  it 'should nullify the dead at date' do
    @create.call
    controller.send(:_negotiation).dead_at.should be_present
  end
end