class Gtps::PreviewContracts::Presenter
  AddressFields = [
      :address1,
      :address2,
      :city,
      :province,
      :country
  ].freeze
  attr_accessor :contract
  delegate :offer,
    :seller_party,
    :buyer_party,
    :price_term,
    :load_term,
    :documents,
    :punishments,
    to: :contract

  delegate :merchant,
    :negotiation_id,
    :negotiation,
    :offer_id,
    to: :offer_contracts_presenter
  def initialize(contract)
    @contract = contract
  end

  def offer_contracts_presenter
    @offer_contracts_presenter ||= FoxYam::Offers::Contracts::Presenter.new offer
  end

  def seller_company_name
    seller_party.try :company_name
  end

  def buyer_company_name
    buyer_party.try :company_name
  end

  def price_terms
    price_term.condition
  end
  def destination
    price_terms.to_s.split(' ').tail.join " "
  end

  def days_seller_has_to_load
    load_term.condition
  end

  def items
    contract.items
  end

  def total_items_cost
    items.sum(&:cost)
  end
  def seller_full_address
    AddressFields.map { |field| seller_party.send field }.join " "
  end
  def seller_phone_number
    seller_party.phone_number
  end
  def seller_email
    seller_party.email
  end
  def buyer_full_address
    AddressFields.map { |field| buyer_party.send field }.join " "
  end
  def buyer_phone_number
    buyer_party.phone_number
  end
  def buyer_email
    buyer_party.email
  end
  def preloading_pictures?
    _doc_names.include? 'preloading_pictures'
  end
  def loading_pictures?
    _doc_names.include? 'loading_pictures'
  end
  def packing_list?
    _doc_names.include? 'packing_list'
  end
  def bill_of_lading?
    _doc_names.include? 'bill_of_lading'
  end
  def weight_ticket?
    _doc_names.include? 'weight_ticket'
  end
  def invoice?
    _doc_names.include? 'invoice'
  end
  def punish_weight?
    _punishment_names.include? 'minimum_average_weight'
  end
  def minimum_packing_weight_before_punishment
    punishments.minimum_average_weights.lower_limit_asc.first.try(:lower_limit)
  end
  def packing_weight_punishments
    punishments.minimum_average_weights
  end
  def minimum_average_weight
    punishments.minimum_average_weights.lower_limit_desc.first.try(:lower_limit)
  end
  def punish_containers?
    _punishment_names.include? 'minimum_containers'
  end
  def incoterm_responsibilities
    _price.incoterm_responsibility_hash
  end
  private
  def _price
    offer.nonscope_latest_price
  end
  def _doc_names
    documents.map(&:document_type)
  end
  def _punishment_names
    punishments.map(&:name)
  end
end