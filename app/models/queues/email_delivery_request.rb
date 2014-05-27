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
  self.table_name = 'queues_email_delivery_requests'
  has_many :email_objects,
    class_name: 'Queues::EmailObject'

  has_one :fulfilment,
    -> { success },
    class_name: 'Queues::EmailDeliveryFulfilment'

  has_many :attempted_fulfilments,
    class_name: 'Queues::EmailDeliveryFulfilment'

  def fulfilled?
    fulfilment.present?
  end

  def unfulfilled?
    !fulfilled
  end
end
