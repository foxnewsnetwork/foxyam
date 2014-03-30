# == Schema Information
#
# Table name: conversations_loads
#
#  id              :integer          not null, primary key
#  conversation_id :integer
#  loads           :integer
#  container_size  :string(255)
#  notes           :string(255)
#

class Conversations::Load < ActiveRecord::Base
  self.table_name = 'conversations_loads'
  belongs_to :conversation
end
