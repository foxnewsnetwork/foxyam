# == Schema Information
#
# Table name: conversations_others
#
#  id              :integer          not null, primary key
#  conversation_id :integer
#  notes           :text
#  created_at      :datetime
#  updated_at      :datetime
#

class Conversations::Other < Conversations::RawLog
  self.table_name = 'conversations_others'
  belongs_to :conversation

end
