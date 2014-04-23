# == Schema Information
#
# Table name: offers
#
#  id             :integer          not null, primary key
#  offer_type     :string(255)      default("sell"), not null
#  company_id     :integer
#  negotiation_id :integer
#  deleted_at     :datetime
#  created_at     :datetime
#  updated_at     :datetime
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

  has_one :latest_price,
    -> { order_latest },
    through: :conversations,
    source: :prices,
    class_name: 'FoxYam::Conversations::Price'

  has_many :materials,
    -> { order_latest },
    through: :conversations,
    class_name: 'FoxYam::Conversations::Material'
  has_many :prices,
    -> { order_latest },
    through: :conversations,
    class_name: 'FoxYam::Conversations::Price'
  has_many :packing_weights,
    -> { order_latest },
    through: :conversations,
    class_name: 'FoxYam::Conversations::PackingWeight'
  has_many :pictures,
    through: :conversations,
    class_name: 'FoxYam::Conversations::Picture'
  has_many :others,
    -> { order_latest },
    through: :conversations,
    class_name: 'FoxYam::Conversations::Other'
  has_many :quantities,
    -> { order_latest },
    through: :conversations,
    class_name: 'FoxYam::Conversations::Quantity'

  scope :sells,
    -> { where "#{self.table_name}.offer_type = ?", :sell }

  scope :buys,
    -> { where "#{self.table_name}.offer_type = ?", :buy }
end
