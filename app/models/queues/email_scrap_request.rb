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
  self.table_name = 'queues_email_scrap_requests'
  belongs_to :email_account,
    class_name: 'FoxYam::EmailAccount'

  has_one :fulfilment,
    -> { success },
    class_name: 'Queues::EmailScrapFulfilment'

  has_many :attempted_fulfilments,
    class_name: 'Queues::EmailScrapFulfilment'

  def fulfilled?
    fulfilment.present?
  end

  def unfulfilled?
    !fulfilled
  end
end
