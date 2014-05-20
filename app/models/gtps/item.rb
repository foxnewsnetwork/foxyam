# == Schema Information
#
# Table name: gtps_items
#
#  id               :integer          not null, primary key
#  contract_id      :integer
#  item_description :string(255)
#  quantity         :decimal(12, 5)
#  quantity_unit    :string(255)
#  unit_price       :decimal(12, 5)
#  created_at       :datetime
#  updated_at       :datetime
#

class Gtps::Item < ActiveRecord::Base
  self.table_name = 'gtps_items'
  belongs_to :contract,
    class_name: 'Gtps::Contract'
end
