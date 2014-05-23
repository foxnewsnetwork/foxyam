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
  PunishmentTypes = [:pay_money, :cancel_contract].freeze
  self.table_name = 'gtps_punishments'
  belongs_to :contract,
    class_name: 'Gtps::Contract'

  scope :pay_monies,
    -> { where "#{self.table_name}.punishment_type = ?", :pay_money }

  scope :cancel_contracts,
    -> { where "#{self.table_name}.punishment_type = ?", :cancel_contracts }

  scope :minimum_average_weights,
    -> { where "#{self.table_name}.name = ?", :minimum_average_weight }

  scope :minimum_containers,
    -> { where "#{self.table_name}.name = ?", :minimum_containers }

  scope :lower_limit_desc,
    -> { order "#{self.table_name}.lower_limit desc"}

  scope :lower_limit_asc,
    -> { order "#{self.table_name}.lower_limit asc"}

  def maximum_quantity
    upper_limit
  end
  def quantity_unit
    return 'containers'.freeze if minimum_containers?
    return 'lbs'.freeze if minimum_average_weight?
  end
  def minimum_containers?
    name == 'minimum_containers'.freeze
  end
  def minimum_average_weight?
    name == 'minimum_average_weight'.freeze
  end
  def minimum_quantity
    lower_limit
  end
  def price_deduction
    return unless pay_money?
    _parse_notes[:amount]
  end
  def price_unit
    return unless pay_money?
    _parse_notes[:unit]
  end
  def pay_money?
    'pay_money'.freeze == punishment_type
  end
  private
  def _parse_notes
    {
      amount: _parsed_amount,
      unit: _parsed_unit
    }
    
  end
  def _parsed_amount
    _parsed_words.first.split.tail.join.to_f
  end
  def _parsed_unit
    _parsed_words.tail.tail.first
  end
  def _parsed_words
    notes.split ' '
  end
end
