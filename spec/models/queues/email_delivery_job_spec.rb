require 'spec_helper'

describe Queues::EmailDeliveryJob do
  let(:request) { Factories::EmailDeliveryRequest.mock }
  let(:job) { described_class.new }
  let(:work) { job.work }
  let(:fulfilment) { request.all_fulfilments.first }
  let(:delivery_result) { job.send :_attempt_email_delivery }
  before { Queues::EmailDeliveryRequest.any_instance.stub(:_create_resque_job).and_return(true) }
  before { EmailInboxInteractor.any_instance.stub(:deliver!).and_return true }
  context '#work' do
    before do
      request
      Factories::EmailDeliveryRequest::TestHelper.any_instance.stub(:four_years_at_berkeley).and_return(:worthless_degree)
      @fcall = lambda { Queues::EmailDeliveryFulfilment.find(fulfilment.id).status }
    end
    specify { delivery_result.should be_right }
    specify { delivery_result.errors.each { |e| raise e } }
    specify { expect { work }.to change(@fcall, :call).from(:untried).to(:succeed) }
    it 'should have all that statuses of a successful fulfilment' do
      work
      fulfilment.tried_at.should be_present
      fulfilment.succeed_at.should be_present
      fulfilment.failed_at.should be_blank
    end
  end
  context '#_mail_class' do
    before { request }
    let(:mail_class) { job.send(:_mail_class) }
    subject { mail_class.payload }    
    specify { should eq Factories::EmailDeliveryRequest::TestHelper }
    specify { mail_class.should be_right }
  end
  context '#_request' do
    before { request }
    subject { job.send(:_request) }
    specify { request.should be_present }
    specify { should eq request }
    specify { should be_a Queues::EmailDeliveryRequest }
  end
  context 'factories' do 
    specify { request.should be_present }
    specify { request.should be_persisted }
    specify { expect { request }.to change(Queues::EmailDeliveryFulfilment, :count).by 1 }
  end
  context '::email_acount' do
    subject { Queues::EmailDeliveryJob.email_account }
    specify { should be_a FoxYam::EmailAccount }
    specify { should be_persisted }
  end
end