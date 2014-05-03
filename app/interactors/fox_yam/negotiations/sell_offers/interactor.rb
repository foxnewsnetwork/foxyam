class FoxYam::Negotiations::SellOffers::Interactor < InteractorBase
  Fields = ::Conversations::Tags::Interactor::Fields.freeze
  attr_accessor :attributes, :negotiation, :merchant, :tag, :company, :offer, :conversation
  attr_hash_accessor *Fields

  def initialize(negotiation: negotiation, merchant: merchant)
    @negotiation, @merchant = negotiation, merchant
  end

  def offer!
    FoxYam::ResultBase.new valid? && _tag
  end

  def valid_with_interactor?
    valid_without_interactor? && _tag_interactor.valid?
  end
  alias_method_chain :valid?, :interactor

  def errors_with_interactor
    ActiveModel::ErrorsHelper.add(errors_without_interactor, _tag_interactor.errors)
  end
  alias_method_chain :errors, :interactor

  private
  def _tag
    @tag ||= _tag_interactor.tag!.tag.tag
  end
  def _tag_interactor
    @tag_interactor ||= ::Conversations::Tags::Interactor.new(_conversation).tap do |i|
      i.attributes = attributes
    end
  end
  def _conversation
    @conversation ||= _offer.conversations.create! _conversation_params
  end
  def _conversation_params
    {
      via: 'fox_yam',
      company: _company
    }
  end
  def _company
    @company ||= merchant.company_with_default
  end
  def _offer
    @offer ||= negotiation.offers.find_or_create_by! _offer_params
  end
  def _offer_params
    {
      offer_type: 'sell',
      company: _company
    }
  end
end