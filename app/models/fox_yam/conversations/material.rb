# == Schema Information
#
# Table name: conversations_materials
#
#  id              :integer          not null, primary key
#  conversation_id :integer
#  material        :string(255)
#  notes           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class FoxYam::Conversations::Material < FoxYam::Conversations::RawLog
  self.table_name = 'conversations_materials'
  belongs_to :conversation, 
    class_name: 'FoxYam::Conversation'

end
