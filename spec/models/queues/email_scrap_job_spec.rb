require 'spec_helper'

describe Queues::EmailScrapJob do
  let(:request) { Factories::EmailScrapRequest.mock }
  let(:job) { described_class.new }
  context '#work' do
    let(:work) { job.work }
    let(:fulfilment) { request.all_fulfilments.first }
    before do
      Queues::EmailScrapRequest.any_instance.stub(:_create_resque_job).and_return(true)
      job.stub(:_interactor).and_return(Factories::EmailScrapRequest::TestHelper.new)
      request
      @fcall = lambda { Queues::EmailScrapFulfilment.find(fulfilment.id).status }
    end
    specify { expect { work }.to change(@fcall, :call).from(:untried).to(:succeed) }
    it 'should have all that statuses of a successful fulfilment' do
      work
      fulfilment.tried_at.should be_present
      fulfilment.succeed_at.should be_present
      fulfilment.failed_at.should be_blank
    end
  end
end