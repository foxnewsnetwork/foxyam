# == Schema Information
#
# Table name: offers
#
#  id             :integer          not null, primary key
#  offer_type     :string(255)      default("sell"), not null
#  company_id     :integer
#  negotiation_id :integer
#  created_at     :datetime
#  updated_at     :datetime
#

class Offer < ActiveRecord::Base
  OfferTypes = [:buy, :sell].freeze
  belongs_to :negotiation
  belongs_to :company

  has_many :conversations

  has_many :materials,
    -> { order_latest },
    through: :conversations,
    class_name: 'Conversations::Material'
  has_many :prices,
    -> { order_latest },
    through: :conversations,
    class_name: 'Conversations::Price'
  has_many :packing_weights,
    -> { order_latest },
    through: :conversations,
    class_name: 'Conversations::PackingWeight'
  has_many :pictures,
    -> { order_latest },
    through: :conversations,
    class_name: 'Conversations::Picture'
  has_many :others,
    -> { order_latest },
    through: :conversations,
    class_name: 'Conversations::Other'
  has_many :quantities,
    -> { order_latest },
    through: :conversations,
    class_name: 'Conversations::Quantity'

    scope :sells,
      -> { where "#{self.table_name}.offer_type = ?", :sell }

    scope :buys,
      -> { where "#{self.table_name}.offer_type = ?", :buy }
end
