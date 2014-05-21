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
    @contract ||= _interactor.tap(&:contract!).contract
  end
  def _tie_offer_with_contract
    offer.contract_relationships.create! contract: _contract
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