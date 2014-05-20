# == Schema Information
#
# Table name: gtps_punishments
#
#  id          :integer          not null, primary key
#  contract_id :integer
#  name        :string(255)
#  upper_limit :integer
#  lower_limit :integer
#  notes       :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Gtps::Punishment < ActiveRecord::Base
  KnownNames = [:minimum_average_weight, :minimum_containers].freeze
  self.table_name = 'gtps_punishments'
  belongs_to :contract,
    class_name: 'Gtps::Contract'
end
