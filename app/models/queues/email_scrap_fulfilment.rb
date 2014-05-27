# == Schema Information
#
# Table name: queues_email_scrap_fulfilments
#
#  id         :integer          not null, primary key
#  request_id :integer
#  succeed_at :datetime
#  failed_at  :datetime
#  created_at :datetime
#  updated_at :datetime
#

class Queues::EmailScrapFulfilment < ActiveRecord::Base
  self.table_name = 'queues_email_scrap_fulfilments'
  belongs_to :request,
    class_name: 'Queues::EmailScrapRequest'

  scope :yes_succeed,
    -> { where "#{self.table_name}.succeed_at is not null" }

  scope :not_failed,
    -> { where "#{self.table_name}.failed_at is null" }
  
  scope :success,
    -> { yes_succeed.not_failed }

  scope :yes_failed,
    -> { where "#{self.table_name}.failed_at is not null" }

  scope :not_succeed,
    -> { where "#{self.table_name}.succeed_at is null" }

  scope :failure,
    -> { yes_failed.not_succeed }
end
