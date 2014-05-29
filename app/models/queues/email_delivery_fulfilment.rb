# == Schema Information
#
# Table name: queues_email_delivery_fulfilments
#
#  id         :integer          not null, primary key
#  request_id :integer
#  succeed_at :datetime
#  failed_at  :datetime
#  tried_at   :datetime
#  created_at :datetime
#  updated_at :datetime
#

class Queues::EmailDeliveryFulfilment < ActiveRecord::Base
  self.table_name = 'queues_email_delivery_fulfilments'
  belongs_to :request,
    class_name: 'Queues::EmailDeliveryRequest'

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

  scope :unattempted,
    -> { not_failed.not_succeed.where "#{self.table_name}.tried_at is null" }

  scope :attempted,
    -> { where "#{self.table_name}.tried_at is not null" }

  scope :inprogress,
    -> { attempted.not_succeed.not_failed }

  def succeed!
    update succeed_at: DateTime.now
  end

  def failed!
    update failed_at: DateTime.now
  end

  def attempt!
    update tried_at: DateTime.now
  end

  def succeed?
    attempted? && succeed_at.to_i > failed_at.to_i
  end

  def attempted?
    tried_at.present?
  end

  def inprogress?
    attempted? && failed_at.blank? && succeed_at.blank?
  end

  def failed?
    attempted? && failed_at.to_i > succeed_at.to_i
  end

  def status
    return :succeed if succeed?
    return :failed if failed?
    return :inprogress if inprogress?
    return :attempted if attempted?
    return :untried
  end
end
