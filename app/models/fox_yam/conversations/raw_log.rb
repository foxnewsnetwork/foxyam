# == Schema Information
#
# Table name: conversations_raw_logs
#
#  id              :integer          not null, primary key
#  conversation_id :integer
#  content         :text
#  created_at      :datetime
#  updated_at      :datetime
#

class FoxYam::Conversations::RawLog < ActiveRecord::Base
  self.table_name = 'conversations_raw_logs'
  belongs_to :conversation, 
    class_name: 'FoxYam::Conversation'
  self.abstract_class = true

  scope :order_latest,
    -> { order("id desc") }

  def tag_type
    self.class.to_s.split("::").last.underscore
  end
end
