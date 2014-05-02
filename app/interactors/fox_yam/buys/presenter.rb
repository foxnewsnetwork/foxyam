class FoxYam::Buys::Presenter

  attr_accessor :merchant
  def initialize(merchant)
    @merchant = merchant
  end

  def materials
    @materials ||= _unique_materials.order('material desc')
  end

  def negotiations
    @negotiations ||= _unfinalized_public_negotiations.order('updated_at desc')
  end

  def negotiation_presenters
    @negotiation_presenters ||= negotiations.map do |negotiation|
      ::Negotiations::ShowPresenter.new negotiation
    end
  end

  private
  def _unique_materials
    @unique_materials ||= FoxYam::Conversations::Material.unique_materials
  end

  def _unfinalized_public_negotiations
    if merchant.present?
      @unfinalized_public_negotiations ||= _negotiation_scope_core.available_for(merchant)
    else
      @unfinalized_public_negotiations ||= _negotiation_scope_core.publicly_available
    end
  end

  def _negotiation_scope_core
    FoxYam::Negotiation.unfinalized.alive.completed.sale_type
  end
end