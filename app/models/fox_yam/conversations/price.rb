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
#  created_at      :datetime
#  updated_at      :datetime
#

class FoxYam::Conversations::Price < FoxYam::Conversations::RawLog
  self.table_name = 'conversations_prices'
  belongs_to :conversation, 
    class_name: 'FoxYam::Conversation'
  belongs_to :place
  Incoterms = YAML.load(File.read(Rails.root.join 'config', 'incoterms.yml'))['Incoterms'].freeze

  def place_name
    place.try(:name)
  end
end
