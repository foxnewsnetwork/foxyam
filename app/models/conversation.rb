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
  has_one :negotiation,
    through: :offer
  belongs_to :company
  has_one :email

  has_many :materials,
    -> { order_latest },
    class_name: 'Conversations::Material'
  has_many :prices,
    -> { order_latest },
    class_name: 'Conversations::Price'
  has_many :packing_weights,
    -> { order_latest },
    class_name: 'Conversations::PackingWeight'
  has_many :pictures,
    -> { order_latest },
    class_name: 'Conversations::Picture'
  has_many :others,
    -> { order_latest },
    class_name: 'Conversations::Other'
  has_many :quantities,
    -> { order_latest },
    class_name: 'Conversations::Quantity'

  def tags
    materials + prices + packing_weights + pictures + others + quantities
  end
end
