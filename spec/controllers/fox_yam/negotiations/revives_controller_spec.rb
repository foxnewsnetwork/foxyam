require 'spec_helper'

describe FoxYam::Negotiations::RevivesController do
  let(:negotiation) { Factories::Negotiation.mock }
  before do
    @create = lambda { post :create, negotiation_id: negotiation.id }
  end
  it 'should nullify the dead at date' do
    @create.call
    negotiation.dead_at.should be_nil
  end
end