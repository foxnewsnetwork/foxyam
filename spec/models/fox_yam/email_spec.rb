require 'spec_helper'

describe FoxYam::Email do
  let(:email) { Factories::Email.mock }
  let(:envelope) { email.envelope }
  let(:origin_from) { email.from_address }
  describe '#from' do
    it 'should create an envelope' do
      expect { origin_from }.to change(FoxYam::Envelope, :count).by 1
    end
  end
  describe '#envelope' do
    it 'should be a persisted envelope' do
      envelope.should be_persisted
      envelope.should be_a FoxYam::Envelope
    end
    it 'should create the envelope' do
      expect { envelope }.to change(FoxYam::Envelope, :count).by 1
    end
  end

  describe '#envelope.from_address' do
    let(:from_address) { envelope.from_address }
    it 'should be a envelopes origin' do
      from_address.should_not be_persisted
      from_address.should be_a FoxYam::Envelopes::Origin
    end
    it 'should persist' do
      from_address.update email_address: Faker::Internet.email
      from_address.should be_persisted
    end
  end
end