require 'spec_helper'

describe FoxYam::Usability::SetupInteractor do
  let(:interactor) { described_class.new }
  let(:email) { interactor.setup! }
  describe '#setup!' do
    it 'should be a correct email' do
      email.should be_a Mail::Message
    end
    it 'should be from buyercompany' do
      email.from.should include 'buyercompany@mailinator.com'
    end
    it 'should html part' do
      email.html_part.should be_present
    end
    it 'should have text part' do
      email.text_part.should be_present
    end
    it 'should have attachments' do
      email.attachments.should be_present
    end
  end
end