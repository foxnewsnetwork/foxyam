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

class Queues::EmailScrapRequest < ActiveRecord::Base
  class << self
    def try_first_unattempted
      transaction do
        r = Queues::EmailScrapRequest.never_attempted.limit(1).first
        r.untried_fulfilment.attempt! if r.try(:untried_fulfilment).present?
        r
      end
    end
  end
  self.table_name = 'queues_email_scrap_requests'
  belongs_to :email_account,
    class_name: 'FoxYam::EmailAccount'

  has_many :successful_fulfilments,
    -> { success },
    foreign_key: 'request_id',
    class_name: 'Queues::EmailScrapFulfilment'

  has_many :failed_fulfilments,
    -> { failure },
    foreign_key: 'request_id',
    class_name: 'Queues::EmailScrapFulfilment'

  has_one :untried_fulfilment,
    -> { unattempted },
    foreign_key: 'request_id',
    class_name: 'Queues::EmailScrapFulfilment'

  has_one :inprogress_fulfilment,
    -> { inprogress },
    foreign_key: 'request_id',
    class_name: 'Queues::EmailScrapFulfilment'

  has_many :all_fulfilments,
    foreign_key: 'request_id',
    class_name: 'Queues::EmailScrapFulfilment'

  scope :never_attempted,
    -> { joins(:untried_fulfilment).order("#{Queues::EmailScrapRequest.table_name}.created_at asc") }

  after_create :_create_fulfilment_and_resque_job

  def fulfilled?
    successful_fulfilments.present?
  end

  def unfulfilled?
    !fulfilled
  end

  private
  def _create_fulfilment_and_resque_job
    _create_fulfilment && _create_resque_job
  end
  def _create_fulfilment
    all_fulfilments.create!
  end
  def _create_resque_job
    Resque.enqueue Queues::EmailScrapJob, id
  end
end
