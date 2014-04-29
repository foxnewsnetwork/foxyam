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
#  place_permalink :string(255)
#

class FoxYam::Conversations::Material < FoxYam::Conversations::RawLog
  self.table_name = 'conversations_materials'
  belongs_to :conversation, 
    class_name: 'FoxYam::Conversation'

  belongs_to :place,
    foreign_key: 'place_permalink',
    primary_key: 'permalink',
    class_name: 'FoxYam::Place'

  scope :unique_materials,
    -> { select('DISTINCT material', 'id') }
end
