class FoxYam::Offers::Contracts::Presenter
  delegate :merchant,
    :merchant_is_selling?,
    :merchant_is_buying?,
    to: :negotiation

  delegate :negotiation,
    :company,
    to: :offer

  attr_accessor :offer

  def initialize(offer)
    @offer = offer
  end
  def party_hashes
    [seller_party_hash, buyer_party_hash]
  end

  def seller_party_hash
    return merchant_hash.merge(party_type: :seller) if merchant_is_selling?
    return company_hash.merge(party_type: :seller)
  end

  def buyer_party_hash
    return company_hash.merge(party_type: :buyer) if merchant_is_selling?
    return merchant_hash.merge(party_type: :buyer)
  end

  def punishment_hashes
    [_minimum_average_weight_params, _cancel_weight_params]
  end

  def requirement_hashes
    [_price_term_params, _load_time_params]
  end

  def company_hash
    {
      email: _company_primary_email,
      company_name: company.company_name
    }
  end

  def merchant_hash
    {
      email: _merchant_primary_email,
      company_name: merchant.name
    }
  end
  def document_hashes
    Gtps::Document::KnownTypes.map do |type|
      { document_type: type }
    end
  end

  def item_hashes
    _complete_line_items.map do |item|
      {
        item_description: item.item_description,
        quantity: item.weight,
        unit_price: item.unit_price,
        quantity_unit: 'lb'
      }
    end
  end
  private
  def _company_primary_email
    company.primary_email || throw(company)
  end
  def _merchant_primary_email
    merchant.primary_email || throw(merchant)
  end
  def _complete_line_items
    asdf = offer.line_items.select do |item|
      item.weight.present? && item.item_description.present? && item.unit_price.present?
    end
    throw offer.line_items if asdf.blank?
    asdf
  end
  def _line_item_presenter
    @li_presenter ||= FoxYam::Offers::Finalizes::LineItemPresenter.new offer
  end
  def _minimum_average_weight_params
    {
      name: :minimum_average_weight,
      lower_limit: 35000,
      notes: '$0.01 per pound missing'
    }
  end
  def _cancel_weight_params
    {
      name: :minimum_average_weight,
      lower_limit: 30000,
      notes: 'Contract cancelled with seller at fault'
    }
  end
  def _price_term_params
    {
      name: :price_terms,
      condition: _price_term_condition
    }
  end
  def _price_term_condition
    [_line_item_presenter.price_term, _line_item_presenter.price_place].select(&:present?).join(' ')
  end
  def _load_time_params
    {
      name: :days_seller_has_to_load,
      condition: '2 weeks'
    }
  end
end