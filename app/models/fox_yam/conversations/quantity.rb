# == Schema Information
#
# Table name: conversations_quantities
#
#  id              :integer          not null, primary key
#  quantity        :integer          not null
#  units           :string(255)      not null
#  notes           :string(255)
#  time_interval   :string(255)      default("one-time"), not null
#  conversation_id :integer
#  created_at      :datetime
#  updated_at      :datetime
#

class FoxYam::Conversations::Quantity < FoxYam::Conversations::RawLog
  self.table_name = 'conversations_quantities'
  belongs_to :conversation, 
    class_name: 'FoxYam::Conversation'

  Units = [:pounds, :containers, :kilograms, :short_tons, :metric_tons].freeze
end
