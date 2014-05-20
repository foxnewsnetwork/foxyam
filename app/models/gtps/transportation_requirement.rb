# == Schema Information
#
# Table name: gtps_transportation_requirements
#
#  id          :integer          not null, primary key
#  contract_id :integer
#  name        :string(255)      not null
#  condition   :string(255)
#  violated_at :datetime
#  notes       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Gtps::TransportationRequirement < ActiveRecord::Base
  KnownNames = [:price_terms, :days_seller_has_to_load].freeze
  self.table_name = 'gtps_transportation_requirements'
  belongs_to :contract,
    class_name: 'Gtps::Contract'

  def violated?
    violated_at.present?
  end
end
