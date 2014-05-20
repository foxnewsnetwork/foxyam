# == Schema Information
#
# Table name: gtps_contracts
#
#  id                    :integer          not null, primary key
#  draft_completed_at    :datetime
#  contract_live_at      :datetime
#  everyone_agreed_at    :datetime
#  contract_disputed_at  :datetime
#  contract_completed_at :datetime
#  contract_canceled_at  :datetime
#  created_at            :datetime
#  updated_at            :datetime
#

class Gtps::Contract < ActiveRecord::Base
  self.table_name = 'gtps_contracts'
  has_one :seller_party,
    -> { seller },
    class_name: 'Gtps::Party'  
  has_one :buyer_party,
    -> { buyer },
    class_name: 'Gtps::Party'

  has_many :parties,
    class_name: 'Gtps::Party'

  has_many :documents,
    class_name: 'Gtps::Document'

  has_many :items,
    class_name: 'Gtps::Item'

  has_many :punishments,
    class_name: 'Gtps::Punishment'

  has_many :transportation_requirements,
    class_name: 'Gtps::TransportationRequirement'

  has_one :offer_relationship,
    class_name: 'FoxYam::Offers::ContractRelationship'

  has_one :offer,
    through: :offer_relationship,
    class_name: 'FoxYam::Offer'
end
