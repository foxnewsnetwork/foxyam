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
  IncoFile = YAML.load(File.read(Rails.root.join 'config', 'incoterms.yml'))
  Incoterms = IncoFile['Incoterms'].map(&:freeze).freeze
  InternationalShippingTerms = ['CPT', 'CFR', 'CIF', 'CIP'].map(&:freeze).freeze
  IncotermDuties = IncoFile['Incoterm Duties'].map(&:freeze).freeze

  def place_name
    place.try(:name)
  end

  def international_shipping?
    InternationalShippingTerms.include? incoterms
  end

  def incoterm_responsibility_hash
    IncotermDuties.zip _responsible_parties
  end

  private
  def _responsible_parties
    IncoFile[incoterm] || raise(NameError, "#{incoterm} is not an known incoterm")
  end
end
