require 'spec_helper'

describe FoxYam::Offers::Finalizes::Interactor do
  let(:offer) { Factories::Offer.mock }
  let(:raw_interactor) { described_class.new offer }
  let(:interactor) { raw_interactor.tap { |i| i.agreed = true } }
  let(:result) { interactor.finalize! }
  describe '#finalize!' do
    it 'should create an line item' do
      expect { result }.to change(FoxYam::LineItem, :count).by 1
    end
  end
  context 'relationships' do
    before { result }
    let(:modded_offer) { interactor.offer }
    specify { offer.should eq modded_offer }
    specify { modded_offer.line_items.should be_present }
  end
end