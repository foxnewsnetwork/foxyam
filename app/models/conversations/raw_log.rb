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

class Conversations::RawLog < ActiveRecord::Base
  self.table_name = 'conversations_raw_logs'
  belongs_to :conversation
end
