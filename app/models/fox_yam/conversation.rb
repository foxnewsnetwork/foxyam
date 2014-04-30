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

class FoxYam::Conversation < ActiveRecord::Base
  ViaTypes = [:gmail, :fox_yam, :phone]
  belongs_to :offer,
    class_name: 'FoxYam::Offer'
  has_one :negotiation,
    through: :offer,
    class_name: 'FoxYam::Negotiation'
  belongs_to :company,
    class_name: 'FoxYam::Company'
  has_one :email,
    class_name: 'FoxYam::Email'

  has_many :attached_files,
    through: :pictures,
    class_name: 'FoxYam::AttachedFile'
  has_many :attachments,
    through: :pictures,
    source: :attached_files,
    class_name: 'FoxYam::AttachedFile'

  has_many :materials,
    -> { order_latest },
    class_name: 'FoxYam::Conversations::Material'
  has_many :prices,
    -> { order_latest },
    class_name: 'FoxYam::Conversations::Price'
  has_many :packing_weights,
    -> { order_latest },
    class_name: 'FoxYam::Conversations::PackingWeight'
  has_many :pictures,
    class_name: 'FoxYam::Conversations::Picture'
  has_many :others,
    -> { order_latest },
    class_name: 'FoxYam::Conversations::Other'
  has_many :quantities,
    -> { order_latest },
    class_name: 'FoxYam::Conversations::Quantity'

  def tags
    materials + prices + packing_weights + others + quantities
  end

end
