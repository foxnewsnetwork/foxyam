# == Schema Information
#
# Table name: fox_yam_offers_contracts
#
#  id          :integer          not null, primary key
#  offer_id    :integer
#  contract_id :integer
#  status      :string(255)      default("normal"), not null
#  created_at  :datetime
#  updated_at  :datetime
#

class FoxYam::Offers::ContractRelationship < ActiveRecord::Base
  self.table_name = 'fox_yam_offers_contracts'
  belongs_to :offer,
    class_name: 'FoxYam::Offer'

  belongs_to :contract,
    class_name: 'Gtps::Contract'
end
