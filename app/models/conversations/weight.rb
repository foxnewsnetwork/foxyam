# == Schema Information
#
# Table name: conversations_weights
#
#  id                  :integer          not null, primary key
#  conversation_id     :integer
#  total_weight_pounds :integer
#  notes               :string(255)
#

class Conversations::Weight < ActiveRecord::Base
  self.table_name = 'conversations_weights'
  belongs_to :conversation
end
