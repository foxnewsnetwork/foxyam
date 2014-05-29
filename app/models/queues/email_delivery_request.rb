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

class Queues::EmailDeliveryRequest < ActiveRecord::Base
  class << self
    def try_first_unattempted
      transaction do
        r = Queues::EmailDeliveryRequest.never_attempted.limit(1).first
        r.untried_fulfilment.attempt! if r.try(:untried_fulfilment).present?
        r
      end
    end
  end
  self.table_name = 'queues_email_delivery_requests'
  has_many :email_objects,
    class_name: 'Queues::EmailObject'

  has_many :successful_fulfilments,
    -> { success },
    foreign_key: 'request_id',
    class_name: 'Queues::EmailDeliveryFulfilment'

  has_many :failed_fulfilments,
    -> { failure },
    foreign_key: 'request_id',
    class_name: 'Queues::EmailDeliveryFulfilment'

  has_one :untried_fulfilment,
    -> { unattempted },
    foreign_key: 'request_id',
    class_name: 'Queues::EmailDeliveryFulfilment'

  has_one :inprogress_fulfilment,
    -> { inprogress },
    foreign_key: 'request_id',
    class_name: 'Queues::EmailDeliveryFulfilment'

  has_many :all_fulfilments,
    foreign_key: 'request_id',
    class_name: 'Queues::EmailDeliveryFulfilment'

  scope :never_attempted,
    -> { joins(:untried_fulfilment).order("#{Queues::EmailDeliveryRequest.table_name}.created_at asc") }

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
    Resque.enqueue Queues::EmailDeliveryJob, id
  end
end
