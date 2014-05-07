class FoxYam::Offers::ShowPresenter
  delegate :negotiation,
    :offer_to_buy?,
    :offer_to_sell?,
    :company,
    :conversations,
    to: :offer

  delegate :merchant,
    to: :negotiation

  attr_accessor :offer
  def initialize(offer)
    @offer = offer
  end

  def merchant_who_made_offer
    company.try :merchant
  end

  def merchant_being_offered
    negotiation.try :merchant
  end

  def negotiation_id
    negotiation.id
  end

  def offer_id
    offer.id
  end

  def offering_company_name
    company.try(:company_name)
  end

  def merchant_company
    merchant.company
  end

  def offering_company_matches?(m)
    return false if merchant_company.blank? || m.blank?
    merchant_company == m.company
  end

  def merchant_matches?(m)
    merchant == m
  end

  def merchant_name
    merchant.name
  end

  def conversation_presenters
    @conversation_presenters ||= conversations_latest_first.map { |convo| FoxYam::Conversations::Presenter.new convo }
  end

  def conversations_latest_first
    conversations.sort { |a,b| a.created_at <=> b.created_at }
  end

end