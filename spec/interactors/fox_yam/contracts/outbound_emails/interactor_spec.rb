require 'spec_helper'

describe FoxYam::Contracts::OutboundEmails::Interactor do
  let(:contract) { Factories::Contract.full_mock }
  let(:interactor) { described_class.new contract }
  before { Queues::EmailDeliveryRequest.any_instance.stub(:_create_resque_job).and_return(true) }
  context 'factories' do
    specify { contract.should be_a Gtps::Contract }
    specify { expect { contract }.to change(Gtps::Item, :count).by 1 }
  end
  describe '#queue_bound_emails' do
    let(:result) { interactor.queue_outbound_email! }
    specify { expect { result }.to change(Queues::EmailDeliveryRequest, :count).by 1 }
    specify { expect { result }.to change(Queues::EmailObject, :count).by 1 }
  end
end