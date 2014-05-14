# == Schema Information
#
# Table name: conversations_packing_weights
#
#  id                    :integer          not null, primary key
#  conversation_id       :integer
#  packing_weight_pounds :integer
#  container_size        :string(255)
#  notes                 :string(255)
#  created_at            :datetime
#  updated_at            :datetime
#

class FoxYam::Conversations::PackingWeight < FoxYam::Conversations::RawLog
  self.table_name = 'conversations_packing_weights'
  DefaultPounds = 40000
  belongs_to :conversation, 
    class_name: 'FoxYam::Conversation'
end
