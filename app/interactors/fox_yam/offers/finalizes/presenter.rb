class FoxYam::Offers::Finalizes::Presenter
  delegate :negotiation,
    :company,
    to: :offer
  delegate :merchant,
    to: :negotiation

  delegate :negotiation_id,
    :offer_id,
    to: :gist_presenter

  delegate :price_term,
    :price_place,
    to: :line_item

  attr_accessor :offer
  
  def gist_presenter
    @gist_presenter ||= FoxYam::Offers::ShowPresenter.new offer
  end

  def merchant_name
    merchant.name
  end

  def merchant_contact
    merchant.company_with_default.try(:primary_contact)
  end

  def merchant_email
    merchant_contact.try(:email)
  end

  def company_name
    company.company_name
  end

  def company_contact_name
    company_contact.try(:name)
  end

  def company_contact_email
    company_contact.try(:email)
  end

  def company_contact
    company.try(:primary_contact)
  end
  
  def initialize(offer)
    @offer = offer
  end
  def merchant_is_selling?(m)
    return if m.blank?
    merchant == m && negotiation.merchant_is_selling?
  end
  def merchant_is_buying?(m)
    return if m.blank?
    merchant == m && negotiation.merchant_is_buying?
  end
  def line_item
    @list_item ||= FoxYam::Offers::Finalizes::LineItemPresenter.new offer
  end
  def line_items
    [line_item]
  end
  def subtotal
    line_items.map(&:item_total).sum
  end
end