# == Schema Information
#
# Table name: conversations_others
#
#  id              :integer          not null, primary key
#  conversation_id :integer
#  notes           :text
#

class Conversations::Other < ActiveRecord::Base
  self.table_name = 'conversations_others'
  belongs_to :conversation
end
