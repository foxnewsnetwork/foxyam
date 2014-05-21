class Gtps::Contracts::Interactor < Gtps::Contracts::BaseInteractor
  MetaFields = [:interactor_type].freeze
  attr_accessor :contract, :results

  validates :_item_interactors,
    presence: true,
    length: { minimum: 1 }
  validates :_party_interactors,
    :_requirement_interactors,
    presence: true,
    length: { is: 2 }

  def valid_with_everybody?
    valid_without_everybody? && _interactor_array.map(&:valid?).all?
  end
  alias_method_chain :valid?, :everybody

  def errors_collection
    _interactor_array.map(&:errors).inject(errors) do |e1, e2|
      FoxYam::Errors.merge e1, e2
    end
  end
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
  def _requirement_interactors
    interactors[:requirements]
  end
  def _party_interactors
    interactors[:parties]
  end
  def _item_interactors
    interactors[:items]
  end
  def _interactor_array
    _interactors_array.flatten
  end
  def _interactors_array
    interactors.to_a.map(&:second)
  end
  def _full_contract
    self.results ||= _interactors_array.map do |interactor_set|
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