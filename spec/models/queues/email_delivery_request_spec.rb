# == Schema Information
#
# Table name: queues_email_delivery_requests
#
#  id            :integer          not null, primary key
#  mail_to       :string(255)
#  mail_from     :string(255)
#  mail_cc_to    :string(255)
#  mail_bcc_to   :string(255)
#  mail_subject  :string(255)
#  mailer_class  :string(255)      not null
#  mailer_method :string(255)      not null
#  created_at    :datetime
#  updated_at    :datetime
#

require 'spec_helper'

describe Queues::EmailDeliveryRequest do
  let(:request) { described_class.create mailer_class: 'TestClass', mailer_method: 'test_method' }
  before { described_class.any_instance.stub(:_create_resque_job).and_return(true) }
  context 'hooks' do
    specify { expect { request }.to change(Queues::EmailDeliveryFulfilment, :count).by 1 }
  end
  context 'fulfilment' do
    let(:fulfilment) { request.untried_fulfilment }
    before { request }
    it 'should be a fulfilment' do
      fulfilment.should be_a Queues::EmailDeliveryFulfilment
    end
    specify { fulfilment.failed_at.should be_blank }
    specify { fulfilment.succeed_at.should be_blank }
    specify { fulfilment.tried_at.should be_blank }
  end
  context 'scopes' do
    let(:requests) { Queues::EmailDeliveryRequest.never_attempted }
    before do
      @request = described_class.create mailer_class: 'AnotherClass', mailer_method: 'another_method'
      @request.all_fulfilments.map(&:succeed!)
      request
    end
    specify { requests.count.should eq 1 }
    specify { requests.should include request }
    specify { requests.should_not include @request }
  end
  describe '#try_first_unattempted' do
    let(:r) { Queues::EmailDeliveryRequest.try_first_unattempted }
    let(:fulfilments) { r.all_fulfilments }
    let(:f) { fulfilments.first }
    let(:uf) { Queues::EmailDeliveryRequest.find(r.id).untried_fulfilment }
    before { request }
    specify { fulfilments.count.should eq 1 }
    specify { f.succeed_at.should be_blank }
    specify { f.failed_at.should be_blank }
    specify { f.tried_at.should be_present }
    specify { r.should be_a Queues::EmailDeliveryRequest }
    specify { uf.should be_blank }
    specify { uf.should_not eq f }
    specify { r.inprogress_fulfilment.should eq f }
  end
end
