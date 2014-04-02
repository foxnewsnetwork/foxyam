# == Schema Information
#
# Table name: conversations
#
#  id         :integer          not null, primary key
#  offer_id   :integer
#  company_id :integer
#  via        :string(255)      default("gmail"), not null
#  created_at :datetime
#  updated_at :datetime
#

class Conversation < ActiveRecord::Base
  belongs_to :offer
  belongs_to :company
  has_one :raw_log,
    class_name: 'Conversation::RawLog'
end
