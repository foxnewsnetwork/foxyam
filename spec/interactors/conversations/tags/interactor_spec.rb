require 'spec_helper'

describe Conversations::Tags::Interactor do
  let(:raw_interactor) { Conversations::Tags::Interactor.new conversation }
  let(:conversation) { Factories::Conversations::Companies::Interactor.new.conversation }
  let(:interactor) { raw_interactor.tap { |i| i.attributes = @params } }
  let(:result) { interactor.tag! }
  describe '#tag!' do
    before do
      @params = {
        tag_type: 'material',
        material: 'HDPE-N',
        notes: Faker::Lorem.sentence
      }
    end
    it 'should generate a successful result' do
      result.should be_success
    end
  end
  context 'relationships' do
    before do
      @params = {
        tag_type: 'material',
        material: 'Delicious Dog Food',
        notes: Faker::Lorem.sentence,
        place_name: 'Long Beach Port' 
      }
    end
    it 'should create a place' do
      expect { result }.to change(FoxYam::Place, :count).by 1
    end
  end
end