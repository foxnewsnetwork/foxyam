class Gtps::Contracts::Interactor < Gtps::Contracts::BaseInteractor
  MetaFields = [:interactor_type].freeze
  attr_accessor :contract, :results
  def contract!
    _contract && _full_contract
  end
  def interactors
    @interactors ||= {}
  end
  def item_params_array=(arr)
    interactors[:items] = _setup_interactor Gtps::Contracts::ItemInteractor, arr
  end
  def document_params_array=(arr)
    interactors[:documents] = _setup_interactor Gtps::Contracts::DocumentInteractor, arr
  end
  def party_params_array=(arr)
    interactors[:parties] = _setup_interactor Gtps::Contracts::PartyInteractor, arr
  end
  def punishment_params_array=(arr)
    interactors[:punishments] = _setup_interactor Gtps::Contracts::PunishmentInteractor, arr
  end
  def requirement_params_array=(arr)
    interactors[:requirements] = _setup_interactor Gtps::Contracts::TransportationRequirementInteractor, arr
  end
  private
  def _full_contract
    self.results ||= interactors.to_a.map(&:second).map do |interactor_set|
      interactor_set.map(&:make!)
    end.flatten
  end
  def _contract
    @contract ||= Gtps::Contract.create!
  end
  def _setup_interactor(interactor_class, hashes)
    hashes.map do |hash|
      interactor_class.new(_contract).tap { |i| i.attributes = hash }
    end
  end
end