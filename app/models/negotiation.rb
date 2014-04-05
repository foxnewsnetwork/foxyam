# == Schema Information
#
# Table name: negotiations
#
#  id           :integer          not null, primary key
#  merchant_id  :integer
#  deleted_at   :datetime
#  dead_at      :datetime
#  finalized_at :datetime
#  completed_at :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class Negotiation < ActiveRecord::Base
  belongs_to :merchant
  has_many :offers

  scope :completed,
    -> { where "#{self.table_name}.completed_at < ?", DateTime.now }

  scope :incomplete,
    -> { where "#{self.table_name}.completed_at is null" }

  def complete!
    update completed_at: DateTime.now
  end
end
