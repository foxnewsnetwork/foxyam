# == Schema Information
#
# Table name: conversations_packing_weights
#
#  id                    :integer          not null, primary key
#  conversation_id       :integer
#  packing_weight_pounds :integer
#  container_size        :string(255)
#  notes                 :string(255)
#

class Conversations::PackingWeight < Conversations::RawLog
  self.table_name = 'conversations_packing_weights'
  belongs_to :conversation

end
