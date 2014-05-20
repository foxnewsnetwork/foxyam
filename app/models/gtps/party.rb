# == Schema Information
#
# Table name: gtps_parties
#
#  id           :integer          not null, primary key
#  contract_id  :integer
#  email        :string(255)
#  company_name :string(255)
#  phone_number :string(255)
#  address1     :string(255)
#  address2     :string(255)
#  city         :string(255)
#  province     :string(255)
#  country      :string(255)
#  party_type   :string(255)      not null
#  created_at   :datetime
#  updated_at   :datetime
#

class Gtps::Party < ActiveRecord::Base
  PartyTypes = [:buyer, :seller].freeze
  self.table_name = 'gtps_parties'
  belongs_to :contract,
    class_name: 'Gtps::Contract'
  scope :buyer,
    -> { where "#{self.table_name}.party_type = ?", :buyer }
  scope :seller,
    -> { where "#{self.table_name}.party_type = ?", :seller }
end
