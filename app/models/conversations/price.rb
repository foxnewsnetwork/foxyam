# == Schema Information
#
# Table name: conversations_prices
#
#  id              :integer          not null, primary key
#  conversation_id :integer
#  place_id        :integer
#  usd_per_pound   :decimal(12, 5)   not null
#  incoterm        :string(255)      default("EXW"), not null
#  notes           :string(255)
#

class Conversations::Price < ActiveRecord::Base
  self.table_name = 'conversations_prices'
  belongs_to :conversation
  belongs_to :place
end
