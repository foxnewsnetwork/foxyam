class Gtps::Contracts::TransportationRequirementInteractor < Gtps::Contracts::BaseInteractor
  Fields = [
    :name,
    :condition,
    :notes
  ].freeze
  attr_hash_accessor *Fields
  attr_accessor :item
  validates :name,
    inclusion: { in: Gtps::TransportationRequirement::KnownNames }
  
  def make!
    _bind_result _valid_with_errors? { _requirement }
  end
  private
  def _requirement
    _update_find_requirement || _create_requirement
  end
  def _update_find_requirement
    _find_requirement.try(:update, _req_params)
    _find_requirement
  end
  def _find_requirement
    @requirement ||= contract.transportation_requirements.find_by_name name
  end
  def _create_requirement
    @requirement ||= contract.transportation_requirements.create! _req_params
  end
  def _req_params
    attributes.permit *Fields
  end
end