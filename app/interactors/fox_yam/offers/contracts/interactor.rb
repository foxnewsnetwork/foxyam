class FoxYam::Offers::Contracts::Interactor < FoxYam::InteractorFoundation  
  attr_accessor :offer, :contract
  delegate :results,
    :valid?,
    :errors_collection,
    to: :_interactor

  def initialize(offer)
    @offer = offer
  end

  def presenter
    @presenter ||= FoxYam::Offers::Contracts::Presenter.new offer
  end

  def make_contract!
    _bind_result valid? && _tie_offer_with_contract && _contract
  end

  private
  def _contract
    _existing_contract || _create_contract
  end
  def _existing_contract
    @contract ||= offer.contracts.first
  end
  def _create_contract
    @contract ||= _interactor.tap(&:contract!).contract
  end
  def _tie_offer_with_contract
    _existing_relationship || _create_relationship
  end
  def _existing_relationship
    offer.contract_relationships.find_by_contract_id _contract.id
  end
  def _create_relationship
    offer.contract_relationships.create! contract: contract
  end
  def _interactor
    @interactor ||= _raw_interactor.tap do |i|
      i.item_params_array = presenter.item_hashes
      i.document_params_array = presenter.document_hashes
      i.party_params_array = presenter.party_hashes
      i.punishment_params_array = presenter.punishment_hashes
      i.requirement_params_array = presenter.requirement_hashes
    end
  end
  def _raw_interactor
    Gtps::Contracts::Interactor.new
  end
  
end