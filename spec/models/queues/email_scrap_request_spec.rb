# == Schema Information
#
# Table name: queues_email_scrap_requests
#
#  id               :integer          not null, primary key
#  email_account_id :integer
#  priority         :integer          default(0), not null
#  created_at       :datetime
#  updated_at       :datetime
#

require 'spec_helper'

describe Queues::EmailScrapRequest do
  let(:email_account) { Factories::EmailAccount.mock }
  let(:request) { described_class.create! email_account: email_account }
  before { described_class.any_instance.stub(:_create_resque_job).and_return(true) }
  context 'hooks' do
    specify { expect { request }.to change(Queues::EmailScrapFulfilment, :count).by 1 }
  end
  context 'fulfilment' do
    let(:fulfilment) { request.untried_fulfilment }
    before { request }
    it 'should be a fulfilment' do
      fulfilment.should be_a Queues::EmailScrapFulfilment
    end
    specify { fulfilment.failed_at.should be_blank }
    specify { fulfilment.succeed_at.should be_blank }
    specify { fulfilment.tried_at.should be_blank }
  end
  context 'scopes' do
    let(:requests) { Queues::EmailScrapRequest.never_attempted }
    before do
      @request = described_class.create! email_account: email_account
      @request.all_fulfilments.map(&:succeed!)
      request
    end
    specify { requests.count.should eq 1 }
    specify { requests.should include request }
    specify { requests.should_not include @request }
  end
  describe '#try_first_unattempted' do
    let(:r) { Queues::EmailScrapRequest.try_first_unattempted }
    let(:fulfilments) { r.all_fulfilments }
    let(:f) { fulfilments.first }
    let(:uf) { Queues::EmailScrapRequest.find(r.id).untried_fulfilment }
    before { request }
    specify { fulfilments.count.should eq 1 }
    specify { f.succeed_at.should be_blank }
    specify { f.failed_at.should be_blank }
    specify { f.tried_at.should be_present }
    specify { r.should be_a Queues::EmailScrapRequest }
    specify { uf.should be_blank }
    specify { uf.should_not eq f }
    specify { r.inprogress_fulfilment.should eq f }
  end
end
