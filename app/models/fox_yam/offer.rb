# == Schema Information
#
# Table name: offers
#
#  id                    :integer          not null, primary key
#  offer_type            :string(255)      default("sell"), not null
#  company_id            :integer
#  negotiation_id        :integer
#  deleted_at            :datetime
#  created_at            :datetime
#  updated_at            :datetime
#  merchant_finalized_at :datetime
#  company_finalized_at  :datetime
#

class FoxYam::Offer < ActiveRecord::Base
  acts_as_paranoid
  OfferTypes = [:buy, :sell].freeze
  belongs_to :negotiation,
    class_name: 'FoxYam::Negotiation'
  belongs_to :company,
    class_name: 'FoxYam::Company'

  has_many :conversations,
    class_name: 'FoxYam::Conversation'
  has_many :attachments,
    through: :conversations,
    class_name: 'FoxYam::AttachedFile'

  has_many :line_items,
    class_name: 'FoxYam::LineItem'

  has_many :contract_relationships,
    class_name: 'FoxYam::Offers::ContractRelationship'

  has_many :contracts,
    through: :contract_relationships,
    class_name: 'Gtps::Contract'

  has_many :materials,
    -> { order("#{FoxYam::Conversations::Material.table_name}.created_at desc") },
    through: :conversations,
    class_name: 'FoxYam::Conversations::Material'
  has_many :prices,
    -> { order("#{FoxYam::Conversations::Price.table_name}.created_at desc") },
    through: :conversations,
    class_name: 'FoxYam::Conversations::Price'
  has_many :packing_weights,
    -> { order("#{FoxYam::Conversations::PackingWeight.table_name}.created_at desc") },
    through: :conversations,
    class_name: 'FoxYam::Conversations::PackingWeight'
  has_many :pictures,
    through: :conversations,
    class_name: 'FoxYam::Conversations::Picture'
  has_many :others,
    -> { order("#{FoxYam::Conversations::Other.table_name}.created_at desc") },
    through: :conversations,
    class_name: 'FoxYam::Conversations::Other'
  has_many :quantities,
    -> { order("#{FoxYam::Conversations::Quantity.table_name}.created_at desc") },
    through: :conversations,
    class_name: 'FoxYam::Conversations::Quantity'

  has_one :latest_price,
    -> { order "#{FoxYam::Conversations::Price.table_name}.created_at desc" },
    through: :conversations,
    source: :prices,
    class_name: 'FoxYam::Conversations::Price'

  scope :sells,
    -> { where "#{self.table_name}.offer_type = ?", :sell }

  scope :buys,
    -> { where "#{self.table_name}.offer_type = ?", :buy }

  scope :company_finalized,
    -> { where "#{self.table_name}.company_finalized_at < ?", DateTime.now }

  scope :merchant_finalized,
    -> { where "#{self.table_name}.merchant_finalized_at < ?", DateTime.now }

  scope :finalized,
    -> { company_finalized.merchant_finalized }
  
  def offer_to_buy?
    'buy' == offer_type
  end

  def offer_to_sell?
    'sell' == offer_type
  end
end
