class Gtps::Contracts::PunishmentInteractor < Gtps::Contracts::BaseInteractor
  Fields = [
    :name,
    :upper_limit,
    :lower_limit,
    :notes
  ].freeze
  attr_hash_accessor *Fields
  attr_accessor :item
  validates :name,
    inclusion: { in: Gtps::Punishment::KnownNames }
  
  def make!
    _bind_result _valid_with_errors? { _punishment }
  end
  private
  def _punishment
    @punishment ||= contract.punishments.create! attributes.permit *Fields
  end
end