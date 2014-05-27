class Factories::Contract
  class << self
    def full_mock
      new.full_mock
    end
  end

  def full_mock
    Factories::Conversation.mock_tags _other_convo
    FoxYam::Offers::Finalizes::Interactor.new(_other_offer).tap { |i| i.agreed = true }.finalize!
    _interactor.tap(&:make_contract!).contract
  end

  private
  def _default_offer
    @default_offer ||= Factories::Conversation.full_mock.offer
  end
  def _other_convo
    @other_convo ||= _other_interactor.tap(&:offer!).conversation
  end
  def _other_offer
    _other_convo.offer
  end

  def _other_interactor
    @other_interactor ||= FoxYam::Negotiations::BuyOffers::Interactor.new(negotiation: _negotiation, merchant: _merchant)
  end
  def _negotiation
    _default_offer.negotiation
  end
  def _merchant
    @merchant ||= Factories::Merchant.mock
  end
  def _interactor
    @interactor ||= FoxYam::Offers::Contracts::Interactor.new _other_offer
  end

end